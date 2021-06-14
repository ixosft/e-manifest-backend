module V1
  class ManifestPeopleParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def index
      values = []
      include = { person: [], manifest: %i[motor source_terminal destination_terminal company] }
      columns = ''
      filter_values, filter, filter_joins = ::V1::FilterService.new(ManifestPerson, params).build_query_params
      filter = filter.strip.present? ? [filter, *filter_values] : []
      query =  columns.present? ? [columns, *values] : []
      { query: query, joins: filter_joins, filter: filter, include: include }
    end

    def create_ticket
      { attrs: manifest_people_params }
    end

    def update_ticket
      { attrs: update_manifest_people_params }
    end

    private

    def manifest_people_params
      @manifest_people_params ||= params.permit(
        :source_state, :source_terminal_id, :destination_state, :destination_terminal_id, :person_id, :amount
      ).tap do |p|
        manifest = Manifest.where(closed: false, motor_id: params[:motor_id]).last
        manifest ||= Manifest.create!(motor_id: params[:motor_id])
        p[:manifest_id] = manifest.id
      end
    end

    def update_manifest_people_params
      @manifest_people_params ||= params.permit(
        :source_state, :source_terminal_id, :destination_state, :destination_terminal_id, :person_id, :amount
      )
    end
  end
end
