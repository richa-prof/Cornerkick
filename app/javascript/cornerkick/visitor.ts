import * as Cookies from 'js-cookie';
import * as uuid from 'uuid';
import {WindowShim} from "./window_shim";

const _VISITOR_COOKIE = '_ck';

export class Visitor {
    private _fingerprint: string;

    constructor(fingerprint: string) {
        this._fingerprint = fingerprint;
    }

    get fingerprint(): string {
        return this._fingerprint;
    }

    static loadVisitor(shim: WindowShim = new WindowShim()): Visitor {
        let hostname = shim.location().hostname;
        let fingerprint = Cookies.get(_VISITOR_COOKIE);

        // temporary.  remove the domain level cookie if exists so we can see the root domain cookie
        Cookies.remove(_VISITOR_COOKIE, { domain: hostname});
        let fingerprintRoot = Cookies.get(_VISITOR_COOKIE);
        if(fingerprintRoot) {
            fingerprint = fingerprintRoot;
        }
        if(!fingerprint) {
            fingerprint = uuid.v4();
        }

        let domain = Visitor.rootDomain(shim.location().hostname);

        // always set the cookie in order to bump the expires value
        Cookies.set(_VISITOR_COOKIE, fingerprint, { domain: domain, expires: 2 * 365 });
        return new Visitor(fingerprint);
    }

    static rootDomain(domain: string): string {
        let root = "";
        let parts = domain.split('.');
        if(parts.length == 1) {
            root = parts[0];
        }
        if(parts.length >= 2) {
            let tld = parts.pop();
            let dom = parts.pop();
            root = `${dom}.${tld}`
        }

        return root;
    }
}
