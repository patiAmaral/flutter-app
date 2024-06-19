# flutter-app
Aplicativo desenvolvido com *__Flutter__* e integrado com o *__Firebase.__*

📚 **Campus Secure - Sistema de Cadastro, Consulta e Gerenciamento de Entrada e Saída de Alunos**
Bem-vindo ao sistema de gerenciamento de entrada e saída de alunos! Este aplicativo foi desenvolvido para facilitar o controle e monitoramento da presença dos alunos em uma instituição de ensino.

📋 **Sobre o Aplicativo**
Este aplicativo oferece uma solução abrangente para registrar, consultar e gerenciar a entrada e saída dos alunos de uma escola. O sistema permite que profissionais da educação como professores, coordenadores e outros funcionários registrem e monitorem os alunos de maneira eficiente e segura.

🚀 **Funcionalidades**
Tela Inicial: Opção de login ou cadastro.
Cadastro: Professores, coordenadores e outros profissionais da educação podem se cadastrar usando email, senha e um código de registro específico (ex: cs-professor, cs-aluno).
Login: Acesso ao sistema utilizando email e senha.
Menu Principal:
Consulta: Acesso às informações dos alunos.
Registrar Aluno: Cadastro de novos alunos.
Registrar Entrada/Saída: Utiliza a câmera do celular para ler o QR Code do aluno e registrar a entrada e saída.

🛠️**Como Funciona**

👨‍🏫 *Cadastro de Profissionais*
Tela Inicial: Selecione a opção de cadastro.
Preencha os Dados: Insira o email, senha e código de registro (ex: cs-professor, cs-coordenador).
Conclusão: Finalize o cadastro.

🔐 *Login*
Tela Inicial: Selecione a opção de login.
Preencha os Dados: Insira o email e senha.
Conclusão: Faça o login.

📑 *Menu Principal*
Após o login, o menu principal oferece as seguintes opções:

Registrar Aluno
Profissionais da educação podem adicionar novos alunos ao banco de dados e gerar um QR Code único para cada aluno baseado na matrícula.

Consulta
Permite que os profissionais da educação consultem as informações dos alunos usando a matrícula.

Registrar Entrada/Saída
Utiliza a câmera do celular para ler o QR Code do aluno e registrar automaticamente a presença, incluindo o horário de entrada e saída.

📱 *Interface do Aluno*
Quando o login é feito com o código cs-aluno, a tela exibirá apenas o QR Code único do aluno, que será usado para registrar a entrada e saída na escola.

📦 *Estrutura do Projeto*
git-bash
/project-root
│
├── /lib
│   ├── main.dart
|   ├──firebase_option.dart
│   ├── /screens
│   │   ├── attendance_screen.dart
│   │   ├── initial_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_student_screen.dart
│   │   ├── register_user_screen.dart
│   │   ├── student_qr_screen.dart
|   |   ├── teacher_main_screen.dart
|   |   └── teacher_scan_screen.dart
│   
├── /assets
│
└── README.md

📥 *Instalação*
*Clone o Repositório:* 
*__Em qualquer terminal:__*
git clone https://github.com/seu-usuario/seu-repositorio.git
cd seu-repositorio

*Instale as Dependências:*
flutter pub get

*Execute o Aplicativo:*
flutter run

🤝 Contribuição
Sinta-se à vontade para contribuir com este projeto. Envie um pull request com melhorias, correções de bugs ou novas funcionalidades.

📄 Licença
Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para mais detalhes.
