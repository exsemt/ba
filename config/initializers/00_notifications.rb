ActiveSupport::Notifications.subscribe "sql.active_record" do |*args|
  @events = []
  event = ActiveSupport::Notifications::Event.new(*args)

  if SUBSCRIBE['SQL'] && "SCHEMA" != event.payload[:name] && !event.payload[:sql].match(/sql_requests|schema_migrations|(DELETE FROM)|(ALTER TABLE)|(INSERT INTO)|(CREATE TABLE)|(DROP DATABASE)|(CREATE DATABASE)/)
    SUBSCRIBE_LOGGER.debug(["NOTIF(sql.active_record):", event.name, event.time, event.end, event.transaction_id, event.payload, "DURATION: #{event.duration}"].join(" || "))

    if event.payload[:sql].match("BEGIN") || !@events.empty?
      @events << event
    end
    if event.payload[:sql].match("COMMIT")
      event = OpenStruct.new(
        :transaction_id => @events.first.transaction_id,
        :time     => @events.first.time,
        :end      => @events.last.end,
        :duration => @events.sum(&:duration),
        :payload  => @events.map(&:payload)
      )
      @events = []
    end

    if @events.empty?
    sql = %{INSERT INTO `sql_requests` (`server_id`, `start`, `finish`, `sql_duration`, `sql_query`, `payload`, `table_size`)
(SELECT '#{event.transaction_id}',
'#{event.time.strftime("%Y-%m-%d %H:%M:%S")}',
'#{event.end.strftime("%Y-%m-%d %H:%M:%S")}',
'#{event.duration}',
'#{(event.payload.is_a?(Array) ? event.payload.map{|p| p[:sql]} : event.payload[:sql]).to_s.gsub("'", '"')}',
'#{event.payload.to_s.gsub("'", '"')}', COUNT(*) FROM star_facts)}

      ActiveRecord::Base.connection.send("insert_sql", sql) #TODO table_size
    end
  end
end
