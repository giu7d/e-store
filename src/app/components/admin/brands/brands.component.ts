import { Component, OnInit } from '@angular/core';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { Brand } from '../../../models/brand.model';
import { BrandService } from '../../../services/brand.service';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-brands',
  templateUrl: './brands.component.html',
  styleUrls: ['./brands.component.css']
})
export class BrandsComponent implements OnInit {
  
  private brandEdit: any;
  private brands: Brand[];

  constructor(private modalService: NgbModal, private $brandService: BrandService) { }

  ngOnInit() {
    this.getBrands();
  }

  addBrand(form: NgForm) {

    if (form.valid) {
      const data = new Brand(Math.random() * 1000, form.value.mar_descricao);
      console.log(data);

      this.$brandService.storeBrand(data).subscribe(
        (res) => {
          form.reset();
          this.getBrands();
        },
        (err) => window.alert(err)
      );
    }
  }

  getBrands() {
    this.$brandService.getBrands()
      .subscribe(
        (res) => this.brands = res.json(),
        (err) => console.log(err)
      );
  }

  deleteBrand(id: number) {
    this.$brandService.deleteBrand(id)
      .subscribe(
        (res) => this.getBrands(),
        (err) => window.alert(err)
      );
  }
  
  getBrandById(id: number) {
    return this.brands.filter(obj => obj['mar_codigo'] === id);
  }

  open(content) {
    this.modalService.open(content, { size: 'sm' });
  }

  edit(id: number, modal) {
    this.brandEdit = this.getBrandById(id);
    this.modalService.open(modal);
  }
}
