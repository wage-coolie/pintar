class UrlShortnerController < ApplicationController
  # handles the post request
  def shortner
    if url_params.key?("url")
      url_record = find_by_url(url_params["url"])
      if (!url_record.nil?)
        return render json: {"description": "The desired shortcode is already in use. Shortcodes are case-sensitive"}, status: 409
      end
      # if shortcode is given then map it to url or else create one shortcode
      if url_params.key?("shortcode")
        # check if that shortcode is already in db
        shortcode_record = find_by_short_code(url_params["shortcode"])
        if (!shortcode_record.nil)
            return render json: {"description": "The desired shortcode is already in use. Shortcodes are case-sensitive."}, status: 409
        end
        if url_params.key("shortcode").match?(/^[0-9a-zA-Z_]{6}$/)
          @url = Url.new(url_params)
          if @url.save
            return render json: {"shortcode": url_params["shortcode"]}, status: 201
          else
            return render json: {"description": "we couldn't save the url due to server error"}, status: 501
          end
        else
          # give error that shortcode did not mmatch regex
          return render json: {"description": "The shortcode fails to meet the following regexp: ^[0-9a-zA-Z_]{6}$"}, status: 422
        end
      else
        code_generated = url_params["url"].split("").map(&:chr).select{|x| x =~ /^[0-9a-zA-Z_]/}.sample(6).join
        @url = Url.new(:url => url_params["url"], :short_code => code_generated)
        if @url.save
            return render json: {"shortcode": code_generated }, status: 201
          else
            return render json: {"description": "we couldn't save the url due to error, maybe the code generated  has already been assigned"}, status: 501
        end
      end
    else
      return render json: {"description": "url is not present"}, status: 400
    end
  end

  # get /:shortcode route mapping
  def get_code
    @shortcode_record = find_by_short_code(params["shortcode"])
    if @shortcode_record
      # render json: {"Location": shortcode_record["url"]}, status: 302
      # increase the redirect_count
      @shortcode_record["redirect_count"] = @shortcode_record["redirect_count"] + 1
      if @shortcode_record.save
        render json: {"Location": @shortcode_record["url"]}, status: 302
      else
        render json: {"description": "got Location: #{@shortcode_record["url"]}, but couldn't update its redirect_count"}, status: 501
      end
    else
      render json: {"description": "The shortcode cannot be found in the system"}, status: 404
    end
  end

  # stats generation
  def stats
    stat_record = find_by_short_code(params["shortcode"])
    if stat_record
      # display in the format we want
      render json: {"startDate": stat_record["created_at"], "redirectCount": stat_record["redirect_count"], "lastSeenDate": stat_record["updated_at"]}
    else
      render json: {"description": "The shortcode cannot be found in the system"}, status: 404
    end
  end

  private
  def url_params
    params.require(:url_shortner).permit(:url, :shortcode)
  end
end
