import {Visitor} from "cornerkick/visitor";
import * as Cookies from 'js-cookie';
import * as uuid from 'uuid';


describe('Visitor', () => {
    describe('loadVisitor', () => {
        describe('previously unseen visitor', () => {
            beforeEach(() => {
                spyOn(Cookies, 'get').and.returnValue(undefined);
                spyOn(Cookies, 'set');
                spyOn(uuid, 'v4').and.returnValue('generated-uuid');
            });

            it('generates a new fingerprint cookie for new visitors', () => {
                let visitor = Visitor.loadVisitor();
                expect(visitor.fingerprint).toEqual('generated-uuid');
            });
        });

        describe('seen visitor', () => {
            beforeEach(() => {
                spyOn(Cookies, 'get').and.returnValue('seen-visitor-fingerprint');
                spyOn(uuid, 'v4');
            });

            it('generates a new fingerprint cookie for new visitors', () => {
                let visitor = Visitor.loadVisitor();
                expect(uuid.v4).not.toHaveBeenCalled();
                expect(visitor.fingerprint).toEqual('seen-visitor-fingerprint');
            });
        });

    });

    describe('rootDomain', () => {
        describe('invalid domains', () => {
            it('returns an empty string when given an empty string', () => {
                expect(Visitor.rootDomain('')).toEqual('');
            });
        });

        describe('valid domains', () => {
            it('handles localhost', () => {
                expect(Visitor.rootDomain('localhost')).toEqual('localhost');
            });

            it('handles domains with a subdomain', () => {
                expect(Visitor.rootDomain('www.cornerkick.io')).toEqual('cornerkick.io');
            });

            it('handles domains without a subdomain', () => {
                expect(Visitor.rootDomain('kick.bz')).toEqual('kick.bz');
            });
        });
    });
});
