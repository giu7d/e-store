import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';

import { AppComponent } from './app.component';
import { AppRouteModule } from './routes/app-route.module';
import { AdminComponent } from './components/admin/admin.component';
import { NavBarComponent } from './components/admin/nav-bar/nav-bar.component';
import { SideBarComponent } from './components/admin/side-bar/side-bar.component';
import { HomeComponent } from './components/admin/home/home.component';
import { OrdersComponent } from './components/admin/orders/orders.component';
import { ProductsComponent } from './components/admin/products/products.component';
import { BrandsComponent } from './components/admin/brands/brands.component';
import { CategoriesComponent } from './components/admin/categories/categories.component';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { CategoryService } from './services/category.service';

@NgModule({
  declarations: [
    AppComponent,
    AdminComponent,
    NavBarComponent,
    SideBarComponent,
    HomeComponent,
    OrdersComponent,
    ProductsComponent,
    BrandsComponent,
    CategoriesComponent
  ],
  imports: [
    NgbModule.forRoot(),
    BrowserModule,
    AppRouteModule,
    FormsModule,
    HttpModule
  ],
  providers: [
    CategoryService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
