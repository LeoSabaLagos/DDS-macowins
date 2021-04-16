

/*  Prendas
Queremos saber el precio de venta de una prenda y sus tipos, */

class Prenda {
	
	var estado;
	
	method precioBase();
	
	method precioFinal() = estado.calcularPrecio(self)
}

// los tipos de prenda son: sacos, pantalones, camisas

object saco inherits Prenda {
	override method precioBase() = 20;
}

object pantalon inherits Prenda {
	override method precioBase() = 50;
}

object camisa inherits Prenda {
	override method precioBase() = 100;
}

// Estados de prendas

class Estado {
	method calcularPrecio(unaPrenda) = unaPrenda.precioBase()
}

// Nueva: en este caso no modifican el precio base. 
object nueva inherits Estado{
	override method calcularPrecio(unaPrenda) = super()
}

// Promoción: Le resta un valor fijo decidido por el usuario
object promocion inherits Estado {
	var descuento = 10;
	
	method calcularPrecio(unaPrenda) = super() - descuento;
}

// Liquidación: Es un 50% del valor del producto.
object liquidacion inherits Estado {
	method calcularPrecio(unaPrenda) = super() * 0.5
}