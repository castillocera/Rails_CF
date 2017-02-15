class ArticlesController < ApplicationController
#CALLBACK se tiene que registrar para que publique:, para que valide o permite hacer en todo exceptop en sohw e index para que la gente pueada lerr los articulos sin loguearse only: [:create,:new] con only las CALLBACK sera solo hazlo en crear y new si no se logueo
#Sirve para ejecutar METODOS antes o despues que suceda acciones en el MODELO o CONTROLADOR
#before_action existe en los controladores lo demas es en el modelo CREANDO OBJETOS http://www.guiasrails.es/active_record_callbacks.html
#before_action :validate_user, except: [:show, :index] #Es CALLBACK CREAMOS UN OBJETO ABAJO, podemos ejecutar en el proceso de rails mientras ejecuta, no dejara comentar mientras no este logueado
before_action :authenticate_user! #esta es un CALLBACK de DEVISE que trae es lo mismo que de arriba la funcion que no deja crear articulos a una eprsona que no esta logueada
                                 #cuando una persona no esta logueada al momento de crear en create dira que no existe el metodo articles para current_user que esta en CREATE de este controlador

#OPTIMIZAR CODIGO REPETIDO CON CALLBACK o refactor
before_action :set_article, except: [:index ,:new, :create] #index,create y new no se repetian ese codigo que esta en el metodo set_article

# get 'articles/index'
#ACCION QUE TRAE LA LISTA DE LOS ARTICULOS
  def index

        @articles = Article.all
  end

#Sirve para crear Articulos NUEVOS, manda a CREATE y tambm a EDIT para editar
 # GET  /articles/new articles#new
  def new
     @articley = Article.new
  end

 # POST /articles   articles#create #aca se acceedde con POST que envia la vista new con el metodo post para create
def create
    #   arrobaarticley = Article.new(article_params) #funciona sin relaciones de uno a muchos
      @articley = current_user.articles.new(article_params) #articles ES UN METODO QUE TIENE current_user.articles por que tiene has_many :articles en el modelo USER
                                                            #current_user TIENE LOS VALORES DEL USUARIO LOGUEADO
      if @articley.save
         redirect_to @articley #si guardo que se redirecciona al articulo creado
      else
         render :new #renderice la vista new que use la vista de NEW significa
      end

  end


  def store
  end

 # GET /articles/:id articles#show
 #SHOW muestra recursos en especificooo, EN ESTE CASO EL ARTICULO ESPECIFICOoo POR SU ID
  def show  #WHERE   #Find  busca registros por id
      #@article = Article.find(params[:id]) #optimizamos con CALLBACK before_action
      @article.update_visits_count #llamamos del modelo que se hizo CALLBACK para que sume las visitas segun se actualice la pagina
  end

  def edit                                  #NO optimizamos con CALLBACK before_action porque la variable es articley hicimos por probar si fuera article si se podria
      @articley = Article.find(params[:id]) #antes de encontrar la vista, encontrara el articulo a editar por su ID
  end

#Si el objeto esta en la BD lo manda a UPDATE, al actualizar O editar
  def update
    #UPDATE
   #   @article.update_attributes({title: 'Nuevo titulo'})
   #@articley = Article.find(params[:id]) #optimizamos con CALLBACK before_action
   if @articley.update(article_params) #pasa los parametros fuertes o strong paramete, que es lo mismo que Article.update(title: params[:article][:title],body: params[:article][:body])
      redirect_to @articley            #solo permitira los parametros fuertes lo que se pide en el formulario el titulo y cuerpo
   else
      render :edit #volverra al formulario editar
   end
  end

 # DELETE /articles/:id      articles#destroy
  def destroy #refactor CALLBACK
     #DELETE FROM articles
    # @article = Article.find(params[:id]) #busca el articulo que desea eliminar el usuario mediante su ID #optimizamos con CALLBACK before_action
     @article.destroy #destruye el objeto de la BD
     redirect_to articles_path #redirecciona
  end

#Strong Parameters, de aca manda al metodo CREATE diciendole que campos necesita aceptar desde la peticion que manda, solo permite estos parametros para que mande al create
#si intenta mandar un campo que no esta en article_params no creara esa peticio, solo accederan los parametros permitidos
#ESTO IRA AL METODO CREATE, por ejemplo para usauario administrador
  private
  def article_params #el article esta en el nombre de los formularios  con un parametro que pide title y body
     params.require(:article).permit(:title,:body) #requiere los parametros que manda los campos del formulario solo permitira los que vengand de la peticion
  end                                              #sOLO ESTOS CAMPOS PERMITIRAN CREARSE CUANDO SE MANDA DESDE LA VISTA DEL FORMULARIO AL create

#CALLBACK
  def validate_user  #CALLBACK mandara a iniciar sesion a la persona que cree articulos sin estar logueado
     redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
  end

 #optimizar los codigos repetidos refactor CALLBACK
 def set_article
    @article = Article.find(params[:id]) #optimizamos con CALLBACK before_action aca lo llamara para todos los metodos
 end

end
