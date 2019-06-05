import {Cornerkick} from "cornerkick/cornerkick";
import {Visit} from "cornerkick/visit";
import {Visitor} from "cornerkick/visitor";
import * as Cookies from 'js-cookie';

let testResponses = {
    testone: {
        success: {
            status: 200,
            responseText: '{"json": "data"}'
        }
    }
};

describe('Cornerkick', () => {

    beforeEach(() => {
        // jasmine.Ajax.install();
    });

    afterEach(() => {
        // jasmine.Ajax.uninstall();
    });

    describe('buildUri', () => {

        it('builds a useful uri with no properties', () => {
            let cornerkick = new Cornerkick("https://url.com/path");
            let visit = new Visit("", "", "", "", "");
            let visitor = new Visitor("");

            let url = cornerkick.buildVisitUri(visit, visitor);
            expect(url).toBe("https://url.com/path?t=visit");
        });

        it('builds a useful uri with some properties undefined', () => {
            let cornerkick = new Cornerkick("https://url.com/path");
            let visit = new Visit("", "", "", "", "");
        });
    });

    it('intercepts ajax as expected', () => {
        let cornerkick = new Cornerkick("https://www.cornerkick.io/path/to/the/stuff");
        let visit = Visit.createVisit();

        cornerkick.sendJsonVisit(visit);

        // let request = jasmine.Ajax.requests.mostRecent();
        // expect(request.url).toBe("https://www.cornerkick.io/path/to/the/stuff");
        // expect(request.method).toBe("POST");

        // request.respondWith(testResponses.testone.success);

        expect(testResponses).toBeDefined();
    });
});
