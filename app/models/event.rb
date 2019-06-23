class Event < ApplicationRecord
  belongs_to :contact, touch: true
  belongs_to :browser
  belongs_to :ip_address

  class Builder
    def initialize(account)
      @account = account
    end

    def fingerprint(fingerprint)
      @fingerprint = fingerprint

      self
    end

    def event_type(event_type)
      @event_type = event_type

      self
    end

    def ip(ip)
      @ip = ip

      self
    end

    def user_agent(user_agent)
      @user_agent = user_agent

      self
    end

    def url(url)
      @url = url

      self
    end

    def referrer(referrer)
      @referrer = referrer

      self
    end

    def title(title)
      @title = title

      self
    end

    def remote_host(remote_host)
      @remote_host = remote_host

      self
    end

    def ga(ga)
      @ga = ga

      self
    end

    def campaign_name(campaign_name)
      @campaign_name = campaign_name

      self
    end

    def campaign_source(campaign_source)
      @campaign_source = campaign_source

      self
    end

    def campaign_medium(campaign_medium)
      @campaign_medium = campaign_medium

      self
    end

    def campaign_term(campaign_term)
      @campaign_term = campaign_term

      self
    end

    def campaign_content(campaign_content)
      @campaign_content = campaign_content

      self
    end

    def node(node)
      @node = node

      self
    end

    def node_class(node_class)
      @node_class = node_class

      self
    end

    def node_href(node_href)
      @node_href = node_href

      self
    end

    def node_properties(node_properties)
      @node_properties = node_properties

      self
    end

    def build
      browser = build_browser
      ip_address = IpAddress.find_or_create_by ip_address: @ip

      event = Event.new(contact: browser.contact, browser: browser, ip_address: ip_address)
      event.event_type = @event_type || 'visit'
      event.url = @url
      event.title = @title
      event.referrer = @referrer

      event.ga = @ga

      event.campaign_name = @campaign_name
      event.campaign_source = @campaign_source
      event.campaign_medium = @campaign_medium
      event.campaign_term = @campaign_term
      event.campaign_content = @campaign_content

      event.node = @node
      event.node_class = @node_class
      event.node_href = @node_href
      begin
        event.node_properties = JSON.parse(@node_properties) unless @node_properties.nil?
      rescue JSON::JSONError
        # just save whatever it is as a string
        event.node_properties = @node_properties
      end

      event.save
      event
    end

    private

    def build_browser
      browser = Browser.find_by(fingerprint: @fingerprint)
      if browser.nil?
        @contact = Contact.create(account: @account)
        browser = Browser.create(fingerprint: @fingerprint, user_agent: @user_agent, contact: @contact)
      end
      browser
    end
  end
end
