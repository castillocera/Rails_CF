class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
   has_many :articles #configuracion de tablas relaciones de uno a muchos, ponemos el controlador o bd su nombre preguntar http://codehero.co/activerecord-asociaciones/
end
