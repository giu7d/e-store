import { Injectable } from '@angular/core';
import { Product } from '../models/product.model';
import { CategoryService } from './category.service';
import { BrandService } from './brand.service';
import { Brand } from '../models/brand.model';
import { Category } from '../models/category.model';
import { Http } from '@angular/http';

@Injectable({
  providedIn: 'root'
})
export class ProductService {

  // private brands: Brand[];
  // private categories: Category[];
  // private products: Product[];
  
  // constructor(private $categoryService: CategoryService, private $brandService: BrandService) {
  //   this.products = [
  //     new Product(0, 'Travis Scott', this.$brandService.getBrandById(0), this.$categoryService.getCategoryById(2), 100.00, '/', 100),
  //     new Product(1, 'Nirvana', this.$brandService.getBrandById(0), this.$categoryService.getCategoryById(2), 100.00, '/', 100)
  //   ];
  // }

  constructor(private http: Http){}

  // public get Products() {
  //   return this.products;
  // }

  // public getProductById(id: number) {
  //   return this.products.filter(
  //     x => x.$id === id
  //   );
  // }

}
