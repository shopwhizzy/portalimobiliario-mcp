# Tools

Generated from the live server (`tools/list`). Descriptions are in Portuguese, as the assistant sees them.

## Everyone

### `search_properties` - Pesquisar imóveis

Pesquisa os imóveis à venda e para arrendar no Portal Imobiliário (Portugal) com filtros: zona, tipo, preço, área, tipologia, características, estado, obra nova e preço face ao valor de mercado. Devolve 24 por página, o €/m² de cada um e o link da mesma pesquisa no portal (para partilhar).

- Arguments: `operacao`, `local`, `tipos`, `preco_min`, `preco_max`, `area_min`, `area_max`, `quartos`, `casas_banho_min`, `caracteristicas`, `estado`, `obra_nova`, `mercado`, `texto`, `ordem`, `pagina`
- Hints: readOnlyHint

### `get_listing` - Detalhe de um imóvel

Detalhe de um imóvel publicado: preço, €/m², comparação com o valor de mercado, áreas, características, descrição, fotos, anunciante e link. Aceita o id, a referência (PIxxxxx) ou o link do imóvel.

- Arguments: `id`
- Hints: readOnlyHint

### `area_prices` - Preços por m² de uma zona

Preço por m² de uma zona de Portugal: valor oficial das vendas (INE) e evolução anual, avaliação bancária, rendas por m², e os preços pedidos nos anúncios do portal (mediana, €/m², número de anúncios) para o tipo e a tipologia indicados. Inclui o link da página de preços e da pesquisa.

- Arguments: `local`, `operacao`, `tipos`, `quartos`
- Hints: readOnlyHint

### `favorites` - Favoritos

Os imóveis favoritos da conta: listar, adicionar ou remover (os mesmos do site).

- Arguments: `action`, `id`
- Hints: idempotentHint

### `create_alert` - Criar alerta de imóveis

Guarda uma pesquisa como alerta: a conta é avisada por email, no portal e aqui (alert_updates) quando surgir um imóvel novo com estes filtros ou quando um baixar de preço. Use mercado=['abaixo'] para oportunidades abaixo do valor de mercado. Máximo 20 alertas por conta. Confirme os filtros com o utilizador antes de criar.

- Arguments: `operacao`, `local`, `tipos`, `preco_min`, `preco_max`, `area_min`, `area_max`, `quartos`, `casas_banho_min`, `caracteristicas`, `estado`, `obra_nova`, `mercado`, `texto`, `nome`, `frequencia`
- Hints: idempotentHint

### `list_alerts` - Os meus alertas

Lista os alertas (pesquisas guardadas) da conta, com a frequência e quantas novidades estão por ver.

- Arguments: none
- Hints: readOnlyHint

### `update_alert` - Alterar alerta

Liga ou desliga um alerta, muda a frequência ou o nome.

- Arguments: `id`, `ativo`, `frequencia`, `nome`
- Hints: idempotentHint

### `delete_alert` - Apagar alerta

Apaga um alerta e as novidades dele. Confirme com o utilizador antes.

- Arguments: `id`
- Hints: destructiveHint, idempotentHint

### `alert_updates` - Novidades dos alertas

Imóveis novos e descidas de preço que os alertas encontraram e ainda não foram vistos (também enviados por email). Por omissão ficam marcados como vistos depois de mostrados.

- Arguments: `alert_id`, `mark_seen`, `limit`
- Hints: none

### `search` - Pesquisar (texto livre)

Pesquisa imóveis no Portal Imobiliário com uma frase (ex.: 'T3 em Braga até 300 mil', 'moradia com piscina para arrendar em Faro'). Devolve ids para usar em fetch. Para filtros precisos, use search_properties.

- Arguments: `query`
- Hints: readOnlyHint

### `fetch` - Abrir imóvel

Devolve o anúncio completo (texto) de um imóvel a partir do id dado por search.

- Arguments: `id`
- Hints: readOnlyHint

### `whoami` - Conta e agências

Mostra a conta ligada, as agências que gere e um resumo dos imóveis. Chama primeiro para saber o contexto.

- Arguments: none
- Hints: readOnlyHint

### `market_stats` - Preços pedidos no portal por zona

Estatísticas de mercado de TODO o portal para uma zona (concelho ou distrito): número de anúncios e preço mediano / €/m² por tipo e tipologia. Útil para avaliar preços.

- Arguments: `location`, `operation`, `type`
- Hints: readOnlyHint

### `find_location` - Procurar localidade

Procura distritos, concelhos e freguesias pelo nome (para usar nomes válidos nos imóveis).

- Arguments: `query`
- Hints: readOnlyHint

### `simulate_imt` - Simular IMT e Imposto do Selo

Calcula o IMT e o Imposto do Selo da compra de um imóvel em Portugal (tabelas do ano em vigor), incluindo IMT Jovem, não residentes, Açores e Madeira, rústicos e compra para revenda. Devolve a regra aplicada e o link para a simulação no site.

- Arguments: `valor`, `vpt`, `finalidade`, `regiao`, `jovem`, `residente`, `credito`
- Hints: readOnlyHint

### `simulate_mortgage` - Simular crédito habitação

Simula um crédito habitação com a Euribor atual: prestação, TAN e TAEG aproximadas, MTIC, taxa de esforço com o teste de stress do Banco de Portugal, garantia pública jovem, dinheiro necessário na escritura (entrada, IMT, selos) e plano anual. Devolve o link da simulação.

- Arguments: `valor`, `entrada`, `prazo`, `tipo`, `indexante`, `spread`, `tanFixa`, `anosFixos`, `idade`, `jovem`, `rendimento`, `outrasPrestacoes`, `finalidade`, `regiao`
- Hints: readOnlyHint

### `simulate_capital_gains` - Simular mais-valias na venda de casa

Calcula o IRS das mais-valias na venda de um imóvel por um residente: coeficiente de desvalorização da moeda, despesas e obras, 50% englobado com os escalões de IRS, reinvestimento (habitação própria, arrendamento a renda moderada, PPR 65+). Devolve o valor que fica e o link.

- Arguments: `venda`, `valorAquisicao`, `anoAquisicao`, `mesAquisicao`, `mesVenda`, `aquisicao`, `despesasCompra`, `despesasVenda`, `obras`, `hpp12`, `reinvest`, `reinvestido`, `emprestimo`, `rendimento`, `conjunta`
- Hints: readOnlyHint

### `estimate_value` - Quanto vale uma casa

Estima o valor de venda e a renda de uma casa (apartamento ou moradia) com os dados oficiais do INE da freguesia ou concelho, ajustados por área, estado e extras; inclui intervalo, confiança e anúncios comparáveis do portal. Serve também para terreno e ruínas (estado 'ruina').

- Arguments: `location`, `tipo`, `area`, `quartos`, `estado`, `garagem`, `exterior`, `piscina`, `elevador`, `terreno`, `terrenoTipo`
- Hints: readOnlyHint

### `official_prices` - Preço oficial por m² (INE) de uma zona

Dados oficiais do INE para um distrito, concelho ou freguesia: valor mediano das vendas por m² (total, casas novas, usadas), variação anual e evolução trimestral, avaliação bancária, rendas por m² dos novos contratos, e as zonas abaixo. Para citar: 'Portal Imobiliário, com dados do INE'.

- Arguments: `location`
- Hints: readOnlyHint

## Agencies and owners

### `manage_feeds` - Importação automática (feeds)

Importação automática: o feed XML ou CSV que o programa de gestão da agência já produz para outros portais (Kyero, eGO, Casafari, Zome...), sincronizado todos os dias (novos entram, alterados atualizam, os que saem do feed são retirados após duas sincronizações). Sem 'action' lista os feeds. action='test' lê o url e mostra quantos imóveis e uma amostra, sem gravar. action='add' liga o feed (url, agency_id) e faz já a primeira importação (no máximo 5 feeds por agência, 2 numa conta sem agência, e 3000 imóveis por feed). action='run' importa agora (feed_id). action='pause' pausa ou retoma; action='delete' apaga o feed (os anúncios ficam).

- Arguments: `action`, `url`, `agency_id`, `feed_id`
- Hints: destructiveHint, openWorldHint

### `list_properties` - Listar os meus imóveis

Lista os imóveis do utilizador (e das suas agências), com filtros. Para admins, all=true lista todo o portal.

- Arguments: `query`, `status`, `operation`, `type`, `concelho`, `agency_id`, `missing`, `limit`, `offset`, `all`
- Hints: readOnlyHint

### `get_property` - Ver um imóvel

Detalhe completo de um imóvel (por id, ref PIxxxxx ou external_ref).

- Arguments: `id`, `ref`, `external_ref`
- Hints: readOnlyHint

### `create_property` - Criar anúncio

Cria um anúncio. Por omissão fica publicado (status active) se tiver localização e preço; usa status='draft' para rascunho.

- Arguments: `property`, `agency_id`, `create_agents`
- Hints: none

### `update_property` - Alterar anúncio

Atualiza só os campos indicados de um imóvel (identifica por id, ref ou external_ref). Fotos novas em 'photos' são acrescentadas.

- Arguments: `id`, `ref`, `external_ref`, `changes`, `create_agents`
- Hints: idempotentHint

### `import_properties` - Importar vários imóveis

Importa vários imóveis de uma vez (até 500 por chamada) a partir de dados estruturados, ideal quando leste um CSV, Excel ou PDF do cliente. Cada item com external_ref existente é atualizado; os outros são criados e publicados. Usa dry_run=true primeiro para ver os erros sem gravar.

- Arguments: `properties`, `agency_id`, `publish`, `dry_run`, `agent_id`, `create_agents`
- Hints: idempotentHint

### `import_csv` - Importar CSV

Importa um CSV (texto ou URL público). Deteta colunas em PT/EN automaticamente (ou usa 'mapping': {coluna: campo}). dry_run=true (por omissão) mostra a correspondência e a validação sem gravar; repete com dry_run=false para importar.

- Arguments: `csv_text`, `csv_url`, `mapping`, `agency_id`, `dry_run`, `publish`, `agent_id`, `create_agents`
- Hints: idempotentHint, openWorldHint

### `set_status` - Mudar estado (vendido, reservado...)

Muda o estado de um ou mais imóveis: active (publicado), draft, reserved, sold, rented, inactive.

- Arguments: `ids`, `refs`, `status`
- Hints: idempotentHint

### `add_photos` - Acrescentar fotos

Acrescenta fotos a um imóvel a partir de URLs públicos (descarregadas e convertidas em segundo plano).

- Arguments: `id`, `ref`, `external_ref`, `urls`
- Hints: openWorldHint

### `delete_property` - Remover anúncio

Remove um anúncio do portal (as fotos são apagadas; fica um registo mínimo para estatística). Indica o motivo: sold_here (vendido pelo portal), sold_elsewhere, rented, off_market, duplicate, other. Se foi vendido/arrendado e o utilizador disser o valor, passa-o em note. Prefere set_status 'inactive' se o utilizador só quiser escondê-lo.

- Arguments: `id`, `ref`, `external_ref`, `reason`, `note`
- Hints: destructiveHint, idempotentHint

### `report_overview` - Relatório dos anúncios

Relatório dos anúncios do utilizador/agência: totais por estado, tipo e concelho, preços (média, mediana, €/m²), visualizações e contactos no período, anúncios mais vistos e anúncios incompletos.

- Arguments: `period_days`, `agency_id`, `all`
- Hints: readOnlyHint

### `report_leads` - Relatório de contactos

Lista os contactos (leads) recebidos no período, com o imóvel, para seguimento.

- Arguments: `period_days`, `property_id`, `limit`
- Hints: readOnlyHint

### `export_properties` - Exportar imóveis (CSV)

Exporta os imóveis do utilizador/agência para CSV (texto), para backup ou para levar para outra ferramenta.

- Arguments: `agency_id`, `status`
- Hints: readOnlyHint

### `manage_agents` - Agentes da agência

Lista ou adiciona agentes de uma agência. Sem 'add' lista os agentes.

- Arguments: `agency_id`, `add`
- Hints: none

### `manage_developments` - Empreendimentos (obra nova)

Empreendimentos (obra nova): um edifício ou projeto com várias frações, cada fração é um anúncio normal ligado ao empreendimento. action: list (os meus), get (id), create/update (campos em 'data'), link/unlink (property_ids), import (só administradores: url de um empreendimento do Imovirtual), delete (id; as frações ficam como anúncios). Fases: project, construction, finished. Localização por nomes (distrito, concelho, freguesia).

- Arguments: `action`, `id`, `url`, `agency_id`, `property_ids`, `data`
- Hints: destructiveHint, openWorldHint

### `audit_listings` - Auditar qualidade dos anúncios

Lista os anúncios ativos (ou rascunhos) com problemas que reduzem visitas e contactos: sem fotos ou com poucas, descrição curta, sem classe energética (obrigatória para publicar), sem mapa, sem área, preço muito acima da mediana da zona, sem atualização há mais de 90 dias. Devolve por anúncio a lista de problemas e o que fazer.

- Arguments: `agency_id`, `status`, `limit`
- Hints: readOnlyHint

### `manage_photos` - Gerir fotos de um anúncio

Lista as fotos de um anúncio; com 'delete' apaga as fotos indicadas (ids); com 'order' define a ordem (lista de ids, a primeira é a capa); com 'cover' põe uma foto como capa. Para acrescentar fotos usa add_photos.

- Arguments: `id`, `ref`, `external_ref`, `delete`, `order`, `cover`
- Hints: destructiveHint, idempotentHint

### `manage_leads` - Contactos recebidos: listar e marcar

Lista os contactos recebidos (pedidos de informação dos anúncios e da página da agência), por ler primeiro. Com 'mark_read' marca como lidos, com 'archive' arquiva (ids). Para responder, usa o email ou telefone do contacto.

- Arguments: `unread_only`, `period_days`, `limit`, `mark_read`, `archive`
- Hints: idempotentHint

### `manage_agency` - Página da agência

Mostra a página da agência (dados, números dos últimos 30 dias: telefone visto, cliques no email e no site; avaliações; selo para o site). Com 'changes' atualiza nome, designação da empresa, AMI, descrição (só texto, sem contactos nem links), morada, telefone, WhatsApp, email ou site.

- Arguments: `agency_id`, `changes`
- Hints: idempotentHint

### `agency_reviews` - Avaliações da agência

Lista as avaliações publicadas da agência (só de clientes que a contactaram pelo portal, verificadas antes de publicar). Com 'reply' responde publicamente a uma avaliação: {review_id, text}. Responde com cordialidade, sem dados pessoais do cliente.

- Arguments: `agency_id`, `reply`
- Hints: idempotentHint
