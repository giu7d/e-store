import { Component, OnInit } from '@angular/core';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { CategoryService } from '../../../services/category.service';
import { Category } from '../../../models/category.model';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-categories',
  templateUrl: './categories.component.html',
  styleUrls: ['./categories.component.css']
})
export class CategoriesComponent implements OnInit {

  private categoryEdit: any;
  private categories: Category[];

  constructor(private modalService: NgbModal, private $categoryService: CategoryService) {}

  ngOnInit() {
    this.getCategories();
  }


  addCategory(form: NgForm){

    if (form.valid){
      const data = new Category(Math.random() * 1000,form.value.cat_descricao);
      console.log(data);
      
      this.$categoryService.storeCategory(data).subscribe(
        (res) => {
          form.reset();
          this.getCategories();
        }, 
        (err) => window.alert(err)
      );
    }
  }

  getCategories(){
    this.$categoryService.getCategories()
    .subscribe(
      (res) => this.categories = res.json(),
      (err) => console.log(err)
    );

  }

  deleteCategory(id: number) {
    this.$categoryService.deleteCategory(id)
    .subscribe(
      (res) => this.getCategories(),
      (err) => window.alert(err)
    );
  }

  getCategoryById(id: number){
    return this.categories.filter(obj => obj['cat_codigo'] === id);
  }

  open(content) {
    this.getCategories();
    this.modalService.open(content, { size: 'sm' });
  }

  edit(id: number, modal) {
    this.categoryEdit = this.getCategoryById(id);
    this.modalService.open(modal);
  }

  

}
