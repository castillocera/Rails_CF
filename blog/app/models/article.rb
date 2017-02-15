class Article < ApplicationRecord
   #VALIDACIONES, aca tambm es un hash pero ruby es flexible y permite ponerlo asi:
   belongs_to :user #configuracion de tablas relaciones de uno a muchos, ponemos el modelo http://codehero.co/activerecord-asociaciones/ 
   validates :title, presence:true, uniqueness:true #requiere llenar el titulo
   validates :body, presence:true, length: { minimum: 5 } #requiere llenar y minimo con 5 letras
end
