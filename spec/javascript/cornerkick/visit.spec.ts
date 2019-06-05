import {Visit} from "cornerkick/visit";
import {WindowShim} from "cornerkick/window_shim";


describe('Visit', () => {
    describe('createVisit', () => {

        describe('direct visit', () => {
            var shim: WindowShim;
            beforeEach(() => {
                shim = new WindowShim();
                let loc: any = {};
                loc.href = 'https://www.testapp.com';

                let doc: any = {};
                doc.title = 'The Title';

                let nav: any = {};
                nav.userAgent = 'Chrome';


                spyOn(shim, 'location').and.returnValue(loc);
                spyOn(shim, 'document').and.returnValue(doc);
                spyOn(shim, 'navigator').and.returnValue(nav);
            });

            it('captures visit properties', () => {
                let visit = Visit.createVisit(shim);
                expect(visit.url).toEqual('https://www.testapp.com');
                expect(visit.title).toEqual('The Title');
                expect(visit.userAgent).toEqual('Chrome');
            });
        });

        describe('clicked link', () => {
            var shim: WindowShim;
            beforeEach(() => {
                shim = new WindowShim();
                let loc: any = {};
                loc.href = 'https://www.testapp.com';

                let doc: any = {};
                doc.title = 'The Title';
                doc.referrer = 'https://www.google.com';

                let nav: any = {};
                nav.userAgent = 'Chrome';

                spyOn(shim, 'location').and.returnValue(loc);
                spyOn(shim, 'document').and.returnValue(doc);
                spyOn(shim, 'navigator').and.returnValue(nav);
            });

            it('captures visit properties', () => {
                let visit = Visit.createVisit(shim);
                expect(visit.url).toEqual('https://www.testapp.com');
                expect(visit.referrer).toEqual('https://www.google.com');
            });
        });

    });
});
