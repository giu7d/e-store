export class Brand {
    
    private mar_codigo: number;
    private mar_descricao: string;

    constructor($mar_codigo: number, $mar_descricao: string) {
        this.mar_codigo = $mar_codigo;
        this.mar_descricao = $mar_descricao;
    }


    /**
     * Getter $mar_codigo
     * @return {number}
     */
	public get $mar_codigo(): number {
		return this.mar_codigo;
	}

    /**
     * Getter $mar_descricao
     * @return {string}
     */
	public get $mar_descricao(): string {
		return this.mar_descricao;
	}

    /**
     * Setter $mar_codigo
     * @param {number} value
     */
	public set $mar_codigo(value: number) {
		this.mar_codigo = value;
	}

    /**
     * Setter $mar_descricao
     * @param {string} value
     */
	public set $mar_descricao(value: string) {
		this.mar_descricao = value;
	}


}