Rails.application.routes.draw do
  get 'welcome/index'
  # root to: 'welcome#index' #ES LO MISCO QUE DE ABAJO
   root :to => 'welcome#index' # le indica a Rails que asocie peticiones de http://localhost:3000/welcome/index a la acción index del controlador welcome. Este fue creado al inicio cuando ejecutaste el generador del controlador (rails generate controller welcome index).
                              #http://localhost:3000/welcome/index
                              #http://localhost:3000/
                              #APARECEN EN ESAS DOS RUTAS
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
