class ArticlesController < ApplicationController

# get 'articles/index'
#ACCION QUE TRAE LA LISTA DE LOS ARTICULOS
  def index
     #SELECT ALL
     #Mandar datos del controlador a la vista
     #creamos la variable de clase articules que es igual
     @articles = Article.all #traera el all todo los registros del modelo Article que llama de la tabla de la BD
  end

#Sirve para crear Articulos NUEVOS, manda a CREATE y tambm a EDIT para editar
 # GET  /articles/new articles#new
  def new
     @articley = Article.new #new crea nuevo articulo
                           #esta variable se manda a la vista NEW donde lo usaran para mandar los parametros a create, porque recien crearan y no se encuentra en la BD
  end

 # POST /articles   articles#create #aca se acceedde con POST que envia la vista new con el metodo post para create
 #del formulario si el elemento aun no esta en la DB lo manda a CREATE, porque cuando llega al save recien almacenara si no la info no esta persistente
  def create                                       #aca el article viene como una parametro en el htm article[body] se debe hacer referencia a losmmbres de los campos article queda por ser nombre del modelo
     #INSERT INTO, en ves de new puede ser create  que llamara a save
     #arrobaarticley = Article.new(title: params[:article][:title],body: params[:article][:body]) #params es un HASH deberia llevar llave pero ruby es flexible
     #articley.save #guada a la base de datos
     #redirect_to articley #redirecciona al articulo creado

     #Strong Parameters-funciona el de arriba agregar arroba
     @articley = Article.new(article_params)

     #trabajar con las mismas variables en NEW y CREATE, trabaje con diferentes funciona pero al validar saldra error
     #ya que new manda la variable a la vista new, y para crear retorna a CREATE, si no no saldra el error se perdera la varible no validara

     #VALIDACIONES - usar mismas variables en NEW y CREATE CUANDO TRABAJAN JUNTOS
   #   article.invalid? #se puede usar apra verdadero o falso
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
  def show  #WHERE               #Find  busca registros por id
      @article = Article.find(params[:id]) #params es un hash o diccionario que buscara el ID que le mande la URI
   #   Article.where("body LIKE ?" , "%hola") #buscara a todos los que tengan hola en el body
   #   Article.where.not("id = ?" , params[:id]) #especificamos que ID no queremos que aparesca
  end

  def edit
      @articley = Article.find(params[:id]) #antes de encontrar la vista, encontrara el articulo a editar por su ID
  end

#Si el objeto esta en la BD lo manda a UPDATE, al actualizar O editar
  def update
    #UPDATE
   #   @article.update_attributes({title: 'Nuevo titulo'})
   @articley = Article.find(params[:id])
   if @articley.update(article_params) #pasa los parametros fuertes o strong paramete, que es lo mismo que Article.update(title: params[:article][:title],body: params[:article][:body])
      redirect_to @articley            #solo permitira los parametros fuertes lo que se pide en el formulario el titulo y cuerpo
   else
      render :edit #volverra al formulario editar
   end
  end

 # DELETE /articles/:id      articles#destroy
  def destroy
     #DELETE FROM articles
     @article = Article.find(params[:id]) #busca el articulo que desea eliminar el usuario mediante su ID
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

end
