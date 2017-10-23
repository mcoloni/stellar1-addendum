#
# Classe controller che implementa le funzionalità CRUD per la classe model "User".
#
class UsersController < ApplicationController

  # Metodo che definisce la creazione di un nuovo membro mediante i parametri 
  # forniti in input. Se l'operazione fallisce, verrà visualizzato un messaggio
  # d'errore.
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render 'error_create', notice: 'Errore!'
    end
  end

  # Metodo che produce la lista degli utenti a cui è scaduta la tessera.
  def list_expired
    @users = User.where("subscription_expiration < ?", DateTime.now).paginate(page: params[:page])
  end

  # Metodo che visualizza i dettagli di un singolo membro.
  def show
    @user = User.find(params[:id])
  end

  # Metodo che restituisce i dettagli dell'utente corrispondente
  # all'identificatore passato in input.
  def edit
    @user = User.find(params[:id])
  end

  # Metodo che applica le modifiche all'utente selezionato.
  def update
    @user = User.find(params[:id])
    redirect_to user_path @user if @user.update(permit_update_params)
  end

  private

  # Metodo che imposta i parametri da specificare obbligatoriamente al momento
  # della creazione di un'istanza di User.
  def user_params
    params.require(:user).permit(:name, :surname, :email, :birth, :subscription_expiration, :password)
  end

  # Metodo che imposta i parametri da specificare obbligatoriamente al momento
  # della modifica di un'istanza di User.
  def permit_update_params
    params.require(:user).permit(:name, :surname, :birth, :subscription_expiration)
  end

end
