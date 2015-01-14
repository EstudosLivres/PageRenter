# All the actions that UPDATE or CREATE records, Register via POST for insertions & PUT for updates
class API::RegistersController < API::BaseAPIController
  # Update the access to Converted
  def conversion
    headers['Content-Type'] = 'application/json'

    # Setup vars & check if params are ok
    access = Access.where(ad_id: params[:ad_id], profile_id: params[:publisher_id], token: params[:secret]).take
    return render json: {error: 'Access not found!'} if access.nil?

    # Resp if it was updated
    updated = access.update(converted: true)

    if updated
      return render json: {success: {msg: 'updated'}}
    else
      return render json: {error: {msg: 'updated'}}
    end
  end
end