require 'securerandom'

module Collect
  #
  # TrackerController
  #
  # Entry point for tracking operations from external sources.
  #
  class TrackerController < ActionController::Base
    before_action :no_cache
    before_action :set_tracker

    #
    # GET request tracker that utilizes a pixel URL with parameters
    # cf = Fingerprint
    # t  = Type
    # ct = Title
    # cr = Referrer
    # cu = URL
    # ca = User Agent
    # ga = GA cookie value
    # n  = Node
    # nh = Node href
    # nc = Node Class
    # np = Node Properties
    # utm_source = utm_source
    # utm_medium = utm_medium
    # utm_term = utm_term
    #
    def pixel
      Event::Builder.new(@tracker.account)
          .fingerprint(params['cf'])
          .event_type(params['t'])
          .title(params['ct'])
          .referrer(params['cr'])
          .url(params['cu'])
          .ga(params['ga'])
          .user_agent(params['ca']) # request.user_agent?
          .ip(request.remote_ip)
          .node(params['n'])
          .node_class(params['nc'])
          .node_href(params['nh'])
          .node_properties(params['np'])
          .build

      send_data PIXEL_IMG, type: 'image/png', disposition: 'inline'
    end

    def submission;
    end

    private

    def no_cache
      request.session_options[:skip] = true
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Request-Method'] = %w[GET POST OPTIONS].join(',')
      headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
      headers['Pragma'] = 'no-cache'
      headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
    end

    def set_tracker
      @tracker = Tracker.find_by(identifier: params[:identifier])
    end
  end
end
