import { Injectable } from "@angular/core";
import { BrowserXhr } from "@angular/http";

@Injectable()
export class CorsSupport extends BrowserXhr {
    constructor() {
        super();
    }
    build(): any {
        let xhr = super.build();
        xhr.withCredentials = true;
        return <any>(xhr);
    }
}