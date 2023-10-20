# frozen_string_literal: true

class ApplicationService
  attr_reader :params, :context

  def self.call(params: {}, context: {}, **args)
    new(params: params, context: context).call(**args)
  end

  def initialize(params: {}, context: {})
    @params = params
    @context = context
  end

  def step(method)
    return unless success?

    send(method)
  end

  def preload(*methods)
    methods.map { |method| send(method) }
  end

  def call
    raise NotImplementedError, '#call method must be implemented'
  end
end
