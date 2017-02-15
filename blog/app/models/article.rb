class Article < ApplicationRecord
   #VALIDACIONES, aca tambm es un hash pero ruby es flexible y permite ponerlo asi:
   belongs_to :user #configuracion de tablas relaciones de uno a muchos, ponemos el modelo http://codehero.co/activerecord-asociaciones/
   validates :title, presence:true, uniqueness:true #requiere llenar el titulo
   validates :body, presence:true, length: { minimum: 5 } #requiere llenar y minimo con 5 letras

   #CALLBACK-creando un OBJETO  -  Active Record http://www.guiasrails.es/active_record_callbacks.html
   #Sirve para ejecutar METODOS antes o despues que suceda acciones en el MODELO o CONTROLADOR
   #para que se sume las visitas en uno cuando visite el articulo
   #before_create :set_visits_count #visits_count esta en el modelo article anteponer set es concenvion en los CALLBACK que haran refactor o meteran algun valor en el modelo
   before_save :set_visits_count #guardara

#metodo que llama el metodo SHOW en el controlador article
   def update_visits_count    #le decimos que actualice el contador de visitas mas el valor del contador de visitas mas uno, este esta en el controlador SHOW que lo usara
      #self.save if self.visits_count.nil?  #que guarde el modelo que ejecutara before_save, la cual ejecutara el metodo set_visits_count, cuando estaba sin valor el contador pero si ya tienen valor se lo quita
      self.update(visits_count: self.visits_count + 1) #el metodo show cada ves que mande actualizara el contador mas 1
   end

   private
   def set_visits_count
      self.visits_count ||= 0 #si el valor de visits_count es nullo que le asigne cero ese valor, si no es nulo que lo deje como estaba
   end
end
