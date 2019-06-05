import {CKEvent} from "cornerkick/ckevent";


describe('CKEvent', () => {
    describe('constructor', () => {

        it('constructs correctly', () => {
            let event = new CKEvent('submit', 'form', 'button', 'submit', '{}');
            expect(event.type).toEqual('submit');
            expect(event.tagName).toEqual('form');
            expect(event.className).toEqual('button');
            expect(event.href).toEqual('submit');
            expect(event.extended).toEqual('{}');
        });
    });
});
