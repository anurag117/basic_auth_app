class SecretCodesController < ApplicationController
  before_action :authorize_resource

  def new
  end

  def create
    codes = SecretCode.generate_random_codes params[:no_of_codes].to_i
    code_values = codes.map{|k| "('#{k}', '#{Time.now.utc.iso8601}', '#{Time.now.utc.iso8601}')"}.join(",")
    sql = "insert into secret_codes (code, created_at, updated_at) values #{code_values}"
    ActiveRecord::Base.connection.execute(sql)
    flash[:notice] = 'codes successfully created.'
    redirect_to action: 'index'
  end

  def index
    @secret_codes = SecretCode.includes(:user).order("id DESC").all
  end

  protected

  def authorize_resource
    authorize! :read, SecretCode
  end

end
