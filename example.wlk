class Elementos{
  method esBueno() = true
  method ataqueDe(unaPlaga){
    unaPlaga.atacar(self)
  }
}

class Hogar inherits Elementos{
  var property mugre 
  var confort

  override method esBueno(){
    return mugre <= confort / 2
  }

  override method ataqueDe(unaPlaga){
    mugre = mugre + unaPlaga.daño()
  }

}

class Huerta inherits Elementos{
  var property produccion
  var nivel
  
  override method esBueno() = produccion > nivel

  override method ataqueDe(unaPlaga){
    produccion = produccion - (unaPlaga.daño() * 0.10)
    if(unaPlaga.transmiteEnfermedades()){
      produccion = (produccion - 10).max(0)
    }
  }
}

class Mascota inherits Elementos{
  var salud

  method saludable() = salud
  
  override method esBueno(){
    return salud > 250
  }

  override method ataqueDe(unaPlaga){
    if(unaPlaga.transmiteEnfermedades()){
      salud = (salud - unaPlaga.daño()).max(0)
    }
  }
}

class Barrios{
  var elementos

  method elementosBuenos() = elementos.filter({e => e.esBueno()})

  method elementosMalos() = elementos.filter({e=> !e.esBueno()})
  method esCopado(){
    return self.elementosBuenos().size() > self.elementosMalos().size() 
  }
}

class Plagas{
  var property poblacion

  method daño(){}

  method transmiteEnfermedades() = poblacion >= 10

  method atacar(unElemento){
    poblacion = poblacion + (poblacion * 0.10)
    unElemento.ataqueDe(self)
  }
}

class Cucarachas inherits Plagas{
  var property peso

  override method daño() =  poblacion / 2

  override method transmiteEnfermedades() {
    super()
    return peso >= 10
  }

  override method atacar(unElemento){
    super(unElemento)
    peso = peso + 2
  }
}

class Pulgas inherits Plagas{

  override method daño() = 2 * poblacion
}

class Garrapatas inherits Pulgas{

  override method atacar(unElemento){
    super(unElemento)
    poblacion = poblacion + (poblacion * 0.10)
  }
}

class Mosquitos inherits Plagas{

  override method daño() = poblacion

  override method transmiteEnfermedades(){
    super()
    return poblacion % 3 == 0
  }
}

