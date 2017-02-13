Rails.application.routes.draw do


 resources :articles
 root :to => 'welcome#index' #pagina PRINCIPAL, root :to => 'articles#new' PAGINA PRINCIPAL SERIA CREAR NUEVO ARTICULO

#genera por defecto ponemos resources
 # GET    /articles          articles#index
 # POST   /articles          articles#create new mandara por post que tendra que responder create en el controlador para crear nuevo elemento
 # GET    /articles/new      articles#new
 # GET    /articles/:id/edit articles#edit
 # GET    /articles/:id      articles#show
 # PATCH  /articles/:id      articles#update
 # PUT    /articles/:id      articles#update
 # DELETE /articles/:id      articles#destroy #- el formulario manda con DELETE busca al metodo DESTROY

  # get 'welcome/index'
  # get 'special', to:'welcome#index'
  # root to: 'welcome#index' #ES LO MISCO QUE DE ABAJO
   # root :to => 'welcome#index' # le indica a Rails que asocie peticiones de http://localhost:3000/welcome/index a la acción index del controlador welcome. Este fue creado al inicio cuando ejecutaste el generador del controlador (rails generate controller welcome index).
                              #http://localhost:3000/welcome/index
                              #http://localhost:3000/
                              #APARECEN EN ESAS DOS RUTAS
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
