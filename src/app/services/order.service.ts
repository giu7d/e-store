import { Injectable } from '@angular/core';
import { Product } from '../models/product.model';
import { ProductService } from './product.service';
import { Order } from '../models/order.model';

@Injectable({
  providedIn: 'root'
})
export class OrderService {

  private products: Product[];
  private orders: Order[];

  constructor(private $productService: ProductService) {
  }
  //   this.orders = [}
  //     new Order(0, this.$productService.Products, [1, 5], '392, Av. Brasil, Centro, Medianeira - PR', 100, 'novo'),
  //     new Order(1, this.$productService.getProductById(0), [2], '2, Av. Brasilia, Independencia, Medianeira - PR', 100, 'novo')
  //   ];
  // }

  // public get Orders() {
  //   return this.orders;
  // }

  // public getOrdersByStatus(status: string) {
  //   return this.orders.filter(
  //     x => x.$status === status
  //   );
  // }

  // public getOrderById(id: number) {
  //   return this.orders.filter(
  //     x => x.$id === id
  //   );
  // }


}
