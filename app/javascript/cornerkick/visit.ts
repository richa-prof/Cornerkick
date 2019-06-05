import * as Cookies from 'js-cookie';
import {WindowShim} from './window_shim';
export class Visit {

    private _url: string;
    private _title: string;
    private _referrer: string;
    private _userAgent: string;
    private _ga: string;

    constructor(url: string, title: string, referrer: string, userAgent: string, ga: string) {
        this._url = url;
        this._title = title;
        this._referrer = referrer;
        this._userAgent = userAgent;
        this._ga = ga;
    }

    get url(): string {
        return this._url;
    }

    get title(): string {
        return this._title;
    }

    get referrer(): string {
        return this._referrer;
    }

    get userAgent(): string {
        return this._userAgent;
    }

    get ga(): string {
        return this._ga;
    }

    toString(): string {
        return `Visit {\n\turl: ${this.url},\n\ttitle: ${this.title},\n\treferrer: ${this.referrer},\n\tuserAgent: ${this.userAgent},\n\tga: ${this.ga}\n}`;
    }

    static createVisit(shim: WindowShim = new WindowShim()): Visit {

        let url = shim.location().href || "";
        let referrer = shim.document().referrer || "";
        let title = shim.document().title || "";
        let userAgent = shim.navigator().userAgent || "";
        let ga = Cookies.get('_ga') || "";

        let visit = new Visit(url, title, referrer, userAgent, ga);
        return visit;
    }
}
