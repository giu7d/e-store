import { Component, OnInit } from '@angular/core';
import { Order } from '../../../models/order.model';
import { OrderService } from '../../../services/order.service';

@Component({
  selector: 'app-orders',
  templateUrl: './orders.component.html',
  styleUrls: ['./orders.component.css']
})
export class OrdersComponent implements OnInit {

  private orders: Order[];

  constructor(private $orderService: OrderService) { }

  ngOnInit() {
    // this.orders = this.$orderService.Orders;
  }


}
