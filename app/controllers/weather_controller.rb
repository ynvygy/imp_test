class WeatherController < ApplicationController
  def temperature_page; end

  def check_weather
    response = WeatherApiService.new(weather_params[:p_code]).check_weather

    redirect_to root_path(temperature_status: response)
  end

  private

  def weather_params
    params.require(:weather).permit(:p_code)
  end
end
