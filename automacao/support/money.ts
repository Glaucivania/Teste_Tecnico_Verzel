/** Valor como a loja exibe: "R$ 1.234,56" (aceita espaço comum ou não separável). */
export const brl = (value: number): RegExp => {
  const [int, dec] = value.toFixed(2).split('.');
  const grouped = int.replace(/\B(?=(\d{3})+(?!\d))/g, '.');
  const escaped = `${grouped},${dec}`.replace(/[.]/g, String.raw`\.`);
  return new RegExp(String.raw`^R\$\s${escaped}$`);
};

/** Desconto como a loja exibe: "- R$ 5,99". */
export const discount = (value: number): RegExp => {
  const base = brl(value).source.replace('^R', String.raw`^-\s?R`);
  return new RegExp(base);
};
