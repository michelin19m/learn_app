class TestsController < ApplicationController
  before_action :set_test, only: %i[show edit update destroy]

  def index
    @tests = Test.all
  end

  def show
  end

  def new
    @test = Test.new
  end

  def edit
  end

  def create
    @test = Test.new(test_params)

    if @test.save
      redirect_to @test, notice: 'Test was successfully created.'
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to @test, notice: 'Test was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_url, notice: 'Test was successfully destroyed.'
  end

  def generate_questions(part)
    client = OpenAI::Client.new(api_key: ENV.fetch("OPENAI_ACCESS_TOKEN"))
    response = client.completions(
      engine: "text-davinci-003",
      parameters: {
        prompt: "Generate test questions based on the following text: #{part.content}",
        max_tokens: 100
      }
    )
    response.choices.first.text
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:part_id, :scheduled_at)
  end
end
