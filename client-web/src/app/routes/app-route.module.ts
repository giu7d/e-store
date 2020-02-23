import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AdminComponent } from '../components/admin/admin.component';
import { HomeComponent } from '../components/admin/home/home.component';
import { OrdersComponent } from '../components/admin/orders/orders.component';
import { ProductsComponent } from '../components/admin/products/products.component';
import { BrandsComponent } from '../components/admin/brands/brands.component';
import { CategoriesComponent } from '../components/admin/categories/categories.component';

export const appRoutes: Routes = [
  {path:'admin', component:AdminComponent, children: [
    { path: '', redirectTo: 'home', pathMatch: 'full' },
    { path: 'home', component: HomeComponent },
    { path: 'orders', component: OrdersComponent},
    { path: 'products', component: ProductsComponent },
    { path: 'brands', component: BrandsComponent },
    { path: 'categories', component: CategoriesComponent },
    { path: '**', redirectTo: 'home', pathMatch: 'full' },
  ]}
];


@NgModule({
  imports: [
    RouterModule.forRoot(appRoutes, { useHash: true })
  ],
  exports: [
    RouterModule
  ]
})
export class AppRouteModule { }
