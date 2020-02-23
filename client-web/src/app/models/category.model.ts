export class Category {

    private cat_codigo: number;
    private cat_descricao: string;

    constructor($cat_codigo: number, $cat_descricao: string) {
        this.cat_codigo = $cat_codigo;
        this.cat_descricao = $cat_descricao;
    }


    /**
     * Getter $cat_codigo
     * @return {number}
     */
	public get $cat_codigo(): number {
		return this.cat_codigo;
	}

    /**
     * Getter $cat_descricao
     * @return {string}
     */
	public get $cat_descricao(): string {
		return this.cat_descricao;
	}

    /**
     * Setter $cat_codigo
     * @param {number} value
     */
	public set $cat_codigo(value: number) {
		this.cat_codigo = value;
	}

    /**
     * Setter $cat_descricao
     * @param {string} value
     */
	public set $cat_descricao(value: string) {
		this.cat_descricao = value;
	}

}