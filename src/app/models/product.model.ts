import { Brand } from "./brand.model";
import { Category } from "./category.model";

export class Product {

    private pro_codigo: number;
    private pro_descricao: string;
    private pro_quantidade: number;
    private brands: Brand[];
    private categories: Category[];
    private pro_valor: number;
    private imgPath: string;
    private avaliation: number

	constructor($pro_codigo: number, $pro_descricao: string, $brands: Brand[], $categories: Category[], $pro_valor: number, $imgPath: string, $pro_quantidade: number) {
		this.pro_codigo = $pro_codigo;
		this.pro_descricao = $pro_descricao;
		this.brands = $brands;
		this.categories = $categories;
		this.pro_valor = $pro_valor;
        this.imgPath = $imgPath;
        this.pro_quantidade = $pro_quantidade;
    }
    

    /**
     * Getter $pro_codigo
     * @return {number}
     */
	public get $pro_codigo(): number {
		return this.pro_codigo;
	}

    /**
     * Getter $pro_descricao
     * @return {string}
     */
	public get $pro_descricao(): string {
		return this.pro_descricao;
	}

    /**
     * Getter $pro_quantidade
     * @return {number}
     */
	public get $pro_quantidade(): number {
		return this.pro_quantidade;
	}

    /**
     * Getter $brands
     * @return {Brand[]}
     */
	public get $brands(): Brand[] {
		return this.brands;
	}

    /**
     * Getter $categories
     * @return {Category[]}
     */
	public get $categories(): Category[] {
		return this.categories;
	}

    /**
     * Getter $pro_valor
     * @return {number}
     */
	public get $pro_valor(): number {
		return this.pro_valor;
	}

    /**
     * Getter $imgPath
     * @return {string}
     */
	public get $imgPath(): string {
		return this.imgPath;
	}

    /**
     * Setter $pro_codigo
     * @param {number} pro_valor
     */
	public set $pro_codigo(pro_valor: number) {
		this.pro_codigo = pro_valor;
	}

    /**
     * Setter $pro_descricao
     * @param {string} pro_valor
     */
	public set $pro_descricao(pro_valor: string) {
		this.pro_descricao = pro_valor;
	}

    /**
     * Setter $pro_quantidade
     * @param {number} pro_valor
     */
	public set $pro_quantidade(pro_valor: number) {
		this.pro_quantidade = pro_valor;
	}

    /**
     * Setter $brands
     * @param {Brand[]} pro_valor
     */
	public set $brands(pro_valor: Brand[]) {
		this.brands = pro_valor;
	}

    /**
     * Setter $categories
     * @param {Category[]} pro_valor
     */
	public set $categories(pro_valor: Category[]) {
		this.categories = pro_valor;
	}

    /**
     * Setter $pro_valor
     * @param {number} pro_valor
     */
	public set $pro_valor(pro_valor: number) {
		this.pro_valor = pro_valor;
	}

    /**
     * Setter $imgPath
     * @param {string} pro_valor
     */
	public set $imgPath(pro_valor: string) {
		this.imgPath = pro_valor;
	}

}