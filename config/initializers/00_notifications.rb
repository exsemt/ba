ActiveSupport::Notifications.subscribe "sql.active_record" do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)

  if SUBSCRIBE['SQL'] && (event.payload[:name] && event.payload[:name].is_a?(Hash) && event.payload[:name][:model].include?("scenario")) && "SCHEMA" != event.payload[:name] &&
      !event.payload[:sql].match(/sql_requests|schema_migrations|(DELETE FROM)|(ALTER TABLE)|(INSERT INTO)|(CREATE TABLE)|(DROP DATABASE)|(CREATE DATABASE)/)

    SUBSCRIBE_LOGGER.debug(["notification(sql.active_record): ", event.name, event.time,
      event.end, event.transaction_id, event.payload, "DURATION: #{event.duration}"].join(" || "))

    sql = %{INSERT INTO `sql_requests` (`server_id`,`start`,`finish`,`sql_duration`,`name`,`scenario`,`sql_query`,`payload`,`table_size`)
      (SELECT '#{event.transaction_id}',
        '#{event.time.strftime("%Y-%m-%d %H:%M:%S")}',
        '#{event.end.strftime("%Y-%m-%d %H:%M:%S")}',
        '#{event.duration}',
        '#{event.payload[:name][:model]}',
        '#{event.payload[:name][:scenario]}',
        '#{(event.payload.is_a?(Array) ? event.payload.map{|p| p[:sql]} : event.payload[:sql]).to_s.gsub("'", '"')}',
        '#{event.payload.to_s.gsub("'", '"')}',
        COUNT(*)
      FROM star_facts)}

    ActiveRecord::Base.connection.send("insert_sql", sql)
  end
end
