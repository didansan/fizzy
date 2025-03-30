module McpIdentification
  extend ActiveSupport::Concern

  included do
    cattr_reader(:mcp_server_id) { ENV["MCP_SERVER_ID"] || "mcp-server-#{SecureRandom.hex(4)}" }

    before_action :set_mcp_ids, if: :mcp_request?
  end

  private
    def set_mcp_ids
      response.headers["X-MCP-Server-ID"]  = mcp_server_id
      response.headers["X-MCP-Request-ID"] = mcp_request_id || generate_mcp_request_id
    end

    def mcp_request?
      mcp_request_id.present?
    end

    def mcp_request_id
      request.headers["X-MCP-Request-ID"]
    end

    def generate_mcp_request_id
      "mcp-req-#{SecureRandom.hex(10)}"
    end
end
