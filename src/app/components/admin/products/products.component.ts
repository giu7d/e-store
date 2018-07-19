import { Component, OnInit } from '@angular/core';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { Product } from '../../../models/product.model';
import { ProductService } from '../../../services/product.service';
import { Brand } from '../../../models/brand.model';
import { Category } from '../../../models/category.model';
import { BrandService } from '../../../services/brand.service';
import { CategoryService } from '../../../services/category.service';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.css']
})
export class ProductsComponent implements OnInit {
  
  private products: Product[];
  private productEdit: Product;
  private brands: Brand[];
  private categories: Category[];


  constructor(private modalService: NgbModal, 
              private $productService: ProductService,
              private $brandService: BrandService,
              private $categoryService: CategoryService) { }

  ngOnInit() {
    // this.products = this.$productService.Products;
    // this.brands = this.$brandService.Brands;
    // this.categories = this.$categoryService.Categories;
  }

  // open(content) {
  //   this.modalService.open(content);
  // }

  // edit(id: number, modal) {
  //   this.productEdit = this.$productService.getProductById(id)[0];
  //   this.open(modal)
  // }

  // delete(id: number) {
  //   console.log(id);
  // }

}
