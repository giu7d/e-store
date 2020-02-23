import { Product } from "./product.model";

export class Order {

    private id: number;
    private products: Product[];
    private qtd: number[];
    private adress: string;
    private finalValue: number;
    private status: string;


	constructor($id: number, $products: Product[], $qtd: number[], $adress: string, $finalValue: number, $status: string) {
		this.id = $id;
        this.products = $products;
        this.qtd = $qtd;
		this.adress = $adress;
		this.finalValue = $finalValue;
		this.status = $status;
	}

    /**
     * Getter $id
     * @return {number}
     */
	public get $id(): number {
		return this.id;
	}

    /**
     * Getter $products
     * @return {Product[]}
     */
	public get $products(): Product[] {
		return this.products;
	}

    /**
     * Getter $products
     * @return {number[]}
     */
    public get $qtd(): number[] {
        return this.qtd;
    }

    /**
     * Getter $adress
     * @return {string}
     */
	public get $adress(): string {
		return this.adress;
	}

    /**
     * Getter $finalValue
     * @return {number}
     */
	public get $finalValue(): number {
		return this.finalValue;
	}

    /**
     * Getter $status
     * @return {string}
     */
	public get $status(): string {
		return this.status;
	}

    /**
     * Setter $id
     * @param {number} value
     */
	public set $id(value: number) {
		this.id = value;
	}

    /**
     * Setter $products
     * @param {Product[]} value
     */
	public set $products(value: Product[]) {
		this.products = value;
    }
    
    /**
         * Setter $products
         * @param {number[]} value
         */
    public set $qtd(value: number[]) {
        this.qtd = value;
    }

    /**
     * Setter $adress
     * @param {string} value
     */
	public set $adress(value: string) {
		this.adress = value;
	}

    /**
     * Setter $finalValue
     * @param {number} value
     */
	public set $finalValue(value: number) {
		this.finalValue = value;
	}

    /**
     * Setter $status
     * @param {string} value
     */
	public set $status(value: string) {
		this.status = value;
	}
    


}