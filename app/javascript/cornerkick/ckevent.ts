/**
 *
 */
export class CKEvent {
    private _type: string;
    private _tagName: string;
    private _className: string;
    private _href: string;
    private _extended: string

    constructor(type: string, tagName: string, className: string, href: string, extended: string) {
        this._type = type;
        this._tagName = tagName;
        this._className = className;
        this._href = href;
        this._extended = extended;
    }


    get type(): string {
        return this._type;
    }

    get tagName(): string {
        return this._tagName;
    }

    get className(): string {
        return this._className;
    }

    get href(): string {
        return this._href;
    }

    get extended(): string {
        return this._extended;
    }

    /**
     * Creates a CKEvent from a DOM Event object
     * @param domEvent
     */
    static createCKEvent(domEvent: Event) : CKEvent {
        let elm : Element = <Element>domEvent.target;

        let tagName = elm.tagName;
        let className = elm.className;
        let href = elm.getAttribute("href") || elm.getAttribute("action") || "";
        let type = domEvent.type;

        let extended : any = {};
        if(tagName == "FORM") {
            let form = elm as HTMLFormElement;
            extended['form-data'] = CKEvent.extractFormData(form);
        }

        let event = new CKEvent(type ,tagName, className, href, JSON.stringify(extended));
        return event;
    }

    static extractFormData(form: HTMLFormElement) : any {
        let formData : any = {};
        let elements = form.elements;
        for (let i = 0; i < elements.length; i++) {
            let element = elements[i];
            switch(element.tagName) {
                case 'INPUT':
                    let input = element as HTMLInputElement;

                    let type = input.getAttribute('type');
                    if(formData[input.name] == null) {
                        formData[input.name] = [];
                    }
                    switch(type) {
                        case 'checkbox':
                        case 'radio':
                            if(input.checked) {
                                formData[input.name].push(input.value);
                            }
                            break;
                        default:
                            formData[input.name].push(input.value);
                            break;
                    }
                    break;
                case 'TEXTAREA':
                    let textarea = element as HTMLTextAreaElement;
                    if(formData[textarea.name] == null) {
                        formData[textarea.name] = [];
                    }
                    formData[textarea.name].push(textarea.value);
                    break;
                case 'SELECT':
                    let select = element as HTMLSelectElement;
                    if(formData[select.name] == null) {
                        formData[select.name] = [];
                    }
                    formData[select.name].push(select.value);
            }
        }
        for(let name in formData) {
            if(formData[name].length == 1) {
                formData[name] = formData[name][0];
            }
        }
        return formData;
    }
}
