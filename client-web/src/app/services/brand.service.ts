import { Injectable } from '@angular/core';
import { Brand } from '../models/brand.model';
import { Headers, RequestOptions, Http } from '@angular/http';

const api = 'http://localhost:3000/brand/';
const headers = new Headers({ 'Content-Type': 'application/json' });
const options = new RequestOptions({ headers: headers });


@Injectable({
  providedIn: 'root'
})
export class BrandService {

  constructor(private http: Http) {}


  public storeBrand(brand: Brand) {
    return this.http.post(api, brand, options);
  }

  public getBrands() {
    return this.http.get(api, options);
  }

  public deleteBrand(id: number) {
    return this.http.delete(api + id, options);
  }

}
