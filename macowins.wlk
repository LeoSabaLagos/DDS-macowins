import prendas.*

// Macowins registra las ventas de estas prendas y necesita saber las ganancias de un determinado día. 


object macowins {
	
	var ventasRealizadas = [];
	
	method coeficienteFijo() = 0.10; // Para los pagos con tarjeta
	
	method gananciasDelDia(unaFecha) = self.ventasDeLaFecha(unaFecha).map({unaVenta => unaVenta.gananciaGenerada()}).sum();
		
	method ventasDeLaFecha(unaFecha) = ventasRealizadas.filter({unaVenta => self.mismaFechaDeVenta(unaFecha,unaVenta)});
	
	method mismaFechaDeVenta(unaFecha,unaVenta) = unaFecha == unaVenta.fecha();
}


// Cada venta tiene asociada las prendas que se vendieron, su cantidad y la fecha de venta

class Venta {
	
	 var prendaVendidas; // objecto saco , camisa o pantalon
	 
	 var cantidadPrendasVendidas;
	 
	 var metodoPago;
	 
	 var fecha;
	 
	 method fecha() = fecha;
	 
	 method gananciaGenerada() = metodoPago.aplicarlo(self);
	 
	 method valorTodasLasPrendas() = prendaVendidas * cantidadPrendasVendidas;
}

// Las ventas pueden ser con dos metodos de pagos
	// en efectivo 
	// o con tarjeta

class MetodoPago {
	method aplicarlo(unaVenta) = unaVenta.gananciaGenerada()
}

// efectivo: no modifica el precio
object efectivo inhertits MetodoPago{
	
}

// tarjeta 
/* 
 mismo comportamiento que en efectivo (el cual no modifica el precio)
 sólo que se le aplica un recargo según la cantidad de cuotas seleccionadas 
 (cantidad de cuotas * un coeficiente fijo + 0.01 del valor de cada prenda)
*/

object tarjeta inherits MetodoPago{
	
	var cantidadCuotas;
	
	override method aplicarlo(unaVenta) = super() + self.recargo(unaVenta)
	
	method recargo(unaVenta) =  cantidadCuotas * macowins.coeficienteFijo() + ( 0.01 * unaVenta.valorTodasLasPrendas() ) 
	//							cantidad de cuotas * un coeficiente fijo    + 	  0.01 del valor de cada prenda		
}