#
# Classe ereditata da tutti i controller.
#
class ApplicationController < ActionController::Base

  layout :set_layout
  protect_from_forgery with: :exception
  # Prima di poter accedere alle funzionalità della pagina, è richiesta
  # l'autenticazione dell'utente.
  before_action :authenticate_user!

  # Questo metodo invoca i metodi richiesti per la visualizzazione della
  # pagina iniziale, dipendentemente dal ruolo dell'utente.
  def index
    if current_user.has_role? :admin
      admin_index
    else
      user_index
    end
  end

  private

  # Metodo che visualizza la pagina iniziale degli utenti amministratori.
  def admin_index
    # Esegue la ricerca degli utenti.
    @q = User.ransack(params[:q])
    # I risultati della ricerca vengono ordinati per qualche attributo ed in seguito paginati.
    @users = @q.result(distinct: true).order(params[:order]).paginate(page: params[:page]) if params[:q].present?
    @users = User.where.not(id: current_user.id).order(params[:order]).paginate(page: params[:page]) unless params[:q].present?
    @user = User.new
    # visualizza la lista degli utenti iscritti.
    render 'users/list'
  end

  # Metodo che visualizza la pagina iniziale degli utenti ordinari.
  def user_index
    # visualizza la pagina iniziale degli utenti ordinari.
  end

  # Metodo per impostare il layout della pagina, sulla base
  # del ruolo dell'utente.
  def set_layout
    if current_user
      case current_user.role
      when "admin"
        "admin"
      when "user"
        "user"
      end
    else
      "default"
    end
  end

end
