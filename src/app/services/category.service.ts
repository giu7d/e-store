import { Injectable } from '@angular/core';
import { Category } from '../models/category.model';
import { Http, Headers, RequestOptions } from '@angular/http';

const api = 'http://localhost:3000/category/';
const headers = new Headers({ 'Content-Type': 'application/json' });
const options = new RequestOptions({ headers: headers });

@Injectable({
  providedIn: 'root'
})
export class CategoryService {

  constructor(private http: Http) {}

  public storeCategory(category: Category){
    return this.http.post(api, category, options);
  }

  public getCategories() {
    return this.http.get(api, options);
  }

  public deleteCategory(id: number) {
    return this.http.delete(api + id, options);
  }


}
