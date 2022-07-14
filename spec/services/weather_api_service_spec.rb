require 'rails_helper'

describe WeatherApiService do
  describe '.check_weather' do
    context 'there is no weather report' do
      let(:body_response) {
        {
          'location' => {
            'country' => 'Mexico'
          }
        }
      }

      it 'should return no uk code message' do
        allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(
          double('response', status: 200, body: body_response.to_json)
        )

        expect(described_class.new('1234').check_weather).to eq('The code does not belong to the UK')
      end

      it 'should return an error' do
        allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(
          double('response', status: 200, body: { 'error' => { 'message' => 'Error test' } }.to_json)
        )
        expect(described_class.new('1234').check_weather).to eq('Error test')
      end
    end

    context 'it returns a type of weather' do
      let(:body_response) {
        {
          'location' => {
            'country' => 'UK'
          },
          'forecast' => {
            'forecastday' => [
              {
                'day' => {
                  'avgtemp_c' => described_class::WARM[:min]
                }
              }
            ]
          }
        }
      }

      let(:avgtemp) { body_response['forecast']['forecastday'][0]['day']['avgtemp_c'] }

      it 'should return WARM' do
        allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(
          double('response', status: 200, body: body_response.to_json)
        )

        expect(described_class.new('ip130sr').check_weather).to eq('WARM')

        body_response['forecast']['forecastday'][0]['day']['avgtemp_c'] = described_class::WARM[:max]
        expect(described_class.new('ip130sr').check_weather).to eq('WARM')
      end

      it 'should return COLD' do
        body_response['forecast']['forecastday'][0]['day']['avgtemp_c'] = described_class::WARM[:min] - 1

        allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(
          double('response', status: 200, body: body_response.to_json)
        )

        expect(described_class.new('ip130sr').check_weather).to eq('COLD')
      end

      it 'should return HOT' do
        body_response['forecast']['forecastday'][0]['day']['avgtemp_c'] = described_class::WARM[:max] + 1

        allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(
          double('response', status: 200, body: body_response.to_json)
        )

        expect(described_class.new('ip130sr').check_weather).to eq('HOT')
      end
    end
  end
end
