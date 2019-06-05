import { CKEvent } from './ckevent';
import { Visit } from './visit';
import { Visitor } from './visitor';

/**
 * Cornerkick main class.
 */
export class Cornerkick {
    private collectUrl: string;
    private visitor: Visitor;
    private visit: Visit;

    private trackingPixels: Array<HTMLImageElement>;

    constructor(collectUrl: string) {
        this.collectUrl = collectUrl;
        this.trackingPixels = [];
    }

    start() {
        this.visitor = Visitor.loadVisitor();

        this.logVisit();
        this.monitorTurbolinks();
        this.monitorEvents();
    }

    monitorTurbolinks() {
        let handler = (e: any) => { this.logVisit(); };
        document.addEventListener('turbolinks:load', handler); // Turbolinks 5
        document.addEventListener('page:load', handler); // Turbolinks 4
    }

    monitorEvents() {
        document.addEventListener('click', (e: MouseEvent) => { this.clickEvent(e); }, true);
        document.addEventListener('submit', (e: Event) => { this.submitEvent(e); }, true);
    }

    logVisit() {
        let visit = Visit.createVisit();
        this.visit = visit;
        this.sendVisit(visit);
    }

    clickEvent(e: MouseEvent) {
        let event = CKEvent.createCKEvent(e);
        this.sendEvent(event);
    }

    submitEvent(e: Event) {
        let event = CKEvent.createCKEvent(e);
        this.sendEvent(event);
    }

    buildEventUri(event: CKEvent, visit: Visit, visitor: Visitor): string {
        /*
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
         *
         */
        let params : any = {
            cf: visitor.fingerprint,
             t: event.type,
            cu: visit.url,
            ct: visit.title,
            cr: visit.referrer,
            ca: visit.userAgent,
            ga: visit.ga,
             n: event.tagName,
            nh: event.href,
            nc: event.className,
            np: event.extended
        };

        return this.buildUri(params);
    }

    buildVisitUri(visit: Visit, visitor: Visitor): string {
        /*
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
         *
         */
        let params : any = {
            cf: visitor.fingerprint,
            cu: visit.url,
            ct: visit.title,
            cr: visit.referrer,
            ca: visit.userAgent,
             t: 'visit',
            ga: visit.ga
        };
        return this.buildUri(params);
    }

    buildUri(params: any): string {
        let accum = [];
        for(let param in params) {
            let value = params[param];
            if(value.length == 0) continue;
            accum.push(`${encodeURIComponent(param)}=${encodeURIComponent(value)}`)
        }
        let query : string = accum.join('&');
        let uri : string = `${this.collectUrl}?${query}`
        if(query.length == 0) {
            uri = this.collectUrl;
        }

        return uri;
    }

    sendEvent(event: CKEvent) {
        let uri = this.buildEventUri(event, this.visit, this.visitor);
        this.imgSend(uri);
    }

    sendVisit(visit: Visit) {
        let uri = this.buildVisitUri(visit, this.visitor);
        this.imgSend(uri);
    }

    private imgSend(uri: string) {
        let img = new Image(1,1);
        img.src = uri;
    }

    sendJsonVisit(visit: Visit) {
        let r = new XMLHttpRequest();
        r.open('POST', this.collectUrl);

        let data: any = {};
        data['referrer'] = 'referrer';

        r.onload = () => {
            console.log(r.responseText);
        };

        r.send(JSON.stringify(data));
    }
}


