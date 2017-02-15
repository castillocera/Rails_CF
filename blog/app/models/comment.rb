class Comment < ApplicationRecord
#belongs_to son por las relaciones de las tablas http://codehero.co/activerecord-asociaciones/ scaffold es inteligente que lo pone solo
  belongs_to :user
  belongs_to :article
end
