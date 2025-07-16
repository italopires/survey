namespace :survey do
  desc 'Import Survey CSV file'
  task csv_import: :environment do
    require 'csv'
    path = Rails.root.join('public', 'data.csv')

    begin
      Survey.transaction do
        survey = Survey.find_or_create_by!(title: 'Pesquisa de Satisfação')

        CSV.open(path, 'r:utf-8', col_sep: ';', headers: true) do |csv|
          headers = csv.first.headers

          csv.first.headers[16..]

          (16..(csv.first.headers.size - 1)).step(2).each do |i|
            question_title = headers[i].strip
            next if question_title.blank?

            question = Question.find_or_create_by!(
              title: question_title,
              survey_id: survey.id,
            )

            (0..10).each do |i|
              QuestionOption.find_or_create_by!(
                question_id: question.id,
                value: i,
              )
            end
          end
        end

        gender_map = {
          'masculino' => 0,
          'feminino' => 1,
          'outro' => 2,
        }

        CSV.foreach(path, headers: true, col_sep: ';', encoding: 'utf-8',) do |row|
          division = Division.find_or_create_by!(name: row['n1_diretoria'])
          department = Department.find_or_create_by!(name: row['n2_gerencia'], division: division)
          team = Team.find_or_create_by!(name: row['n3_coordenacao'], department: department)
          sub_team = SubTeam.find_or_create_by!(name: row['n4_area'], team: team)

          employee = Employee.find_or_create_by!(corporate_email: row['email_corporativo']) do |e|
            e.name = row['nome']
            e.personal_email = row['email']
            e.area = row['area']
            e.role = row['cargo']
            e.role_kind = row['funcao']
            e.location = row['localidade']
            e.company_tenure = row['tempo_de_empresa']
            e.gender = gender_map.fetch(row['genero'].to_s.downcase, 2)
            e.generation = row['geracao']
            e.sub_team = sub_team
          end

          (16..(row.headers.size - 1)).step(2).each do |i|
            question_title = row.headers[i].strip

            question = Question.find_by(
              title: question_title,
              survey_id: survey.id,
            )
            option = QuestionOption.find_by(
              question_id: question.id,
              value: row[i],
            )

            EmployeeAnswer.find_or_create_by!(
              employee_id: employee.id,
              question_id: question.id,
              question_option_id: option.id,
              survey_id: survey.id,
              comment: row[i+1],
              created_at: DateTime.strptime(row['Data da Resposta'], '%d/%m/%Y')
            )
          end
        end
      end

      puts 'Importação finalizada com sucesso.'
    rescue => e
      puts "Detalhes: #{e.class} - #{e.message}"
    end
  end
end
