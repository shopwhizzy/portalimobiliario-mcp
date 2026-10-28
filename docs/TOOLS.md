# Tools

Generated from the live server (`tools/list`). One tool per operation. Descriptions are in Portuguese, as the assistant sees them.

## Everyone

### `search_properties` - Pesquisar imóveis

Pesquisa os imóveis à venda e para arrendar no Portal Imobiliário (Portugal) com filtros: zona, tipo, preço, área, tipologia, características, estado, obra nova e preço face ao valor de mercado. Devolve 24 por página, o €/m² de cada um e o link da mesma pesquisa no portal (para partilhar).

- Arguments: `operacao`, `local`, `tipos`, `preco_min`, `preco_max`, `area_min`, `area_max`, `quartos`, `casas_banho_min`, `caracteristicas`, `estado`, `obra_nova`, `mercado`, `texto`, `ordem`, `pagina`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `get_listing` - Detalhe de um imóvel

Detalhe de um imóvel publicado: preço, €/m², comparação com o valor de mercado, áreas, características, descrição, fotos, anunciante e link. Aceita o id, a referência (PIxxxxx) ou o link do imóvel.

- Arguments: `id`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `area_prices` - Preços por m² de uma zona

Preço por m² de uma zona de Portugal: valor oficial das vendas (INE) e evolução anual, avaliação bancária, rendas por m², e os preços pedidos nos anúncios do portal (mediana, €/m², número de anúncios) para o tipo e a tipologia indicados. Inclui o link da página de preços e da pesquisa.

- Arguments: `local`, `operacao`, `tipos`, `quartos`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `list_favorites` - Os meus favoritos

Lista os imóveis favoritos da conta (os mesmos do site), com preço, se ainda estão disponíveis e o link.

- Arguments: none
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `add_favorite` - Guardar nos favoritos

Guarda um imóvel nos favoritos da conta (id de search_properties ou get_listing).

- Arguments: `id`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `remove_favorite` - Tirar dos favoritos

Tira um imóvel dos favoritos da conta.

- Arguments: `id`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: false

### `create_alert` - Criar alerta de imóveis

Guarda uma pesquisa como alerta: a conta é avisada por email, no portal e aqui (alert_updates) quando surgir um imóvel novo com estes filtros ou quando um baixar de preço. Use mercado=['abaixo'] para oportunidades abaixo do valor de mercado. Máximo 20 alertas por conta. Confirme os filtros com o utilizador antes de criar.

- Arguments: `operacao`, `local`, `tipos`, `preco_min`, `preco_max`, `area_min`, `area_max`, `quartos`, `casas_banho_min`, `caracteristicas`, `estado`, `obra_nova`, `mercado`, `texto`, `nome`, `frequencia`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `list_alerts` - Os meus alertas

Lista os alertas (pesquisas guardadas) da conta, com a frequência e quantas novidades estão por ver.

- Arguments: none
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `update_alert` - Alterar alerta

Liga ou desliga um alerta, muda a frequência ou o nome.

- Arguments: `id`, `ativo`, `frequencia`, `nome`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `delete_alert` - Apagar alerta

Apaga um alerta e as novidades dele. Confirme com o utilizador antes.

- Arguments: `id`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: false

### `alert_updates` - Novidades dos alertas

Imóveis novos e descidas de preço que os alertas encontraram e ainda não foram vistos (também enviados por email). Por omissão ficam marcados como vistos depois de mostrados.

- Arguments: `alert_id`, `mark_seen`, `limit`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `search` - Pesquisar (texto livre)

Pesquisa imóveis no Portal Imobiliário com uma frase (ex.: 'T3 em Braga até 300 mil', 'moradia com piscina para arrendar em Faro'). Devolve ids para usar em fetch. Para filtros precisos, use search_properties.

- Arguments: `query`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `fetch` - Abrir imóvel

Devolve o anúncio completo (texto) de um imóvel a partir do id dado por search.

- Arguments: `id`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `whoami` - Conta e agências

Mostra a conta ligada, as agências que gere e um resumo dos imóveis. Chama primeiro para saber o contexto.

- Arguments: none
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `market_stats` - Preços pedidos no portal por zona

Estatísticas de mercado de TODO o portal para uma zona (concelho ou distrito): número de anúncios e preço mediano / €/m² por tipo e tipologia. Útil para avaliar preços.

- Arguments: `location`, `operation`, `type`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `find_location` - Procurar localidade

Procura distritos, concelhos e freguesias pelo nome (para usar nomes válidos nos imóveis).

- Arguments: `query`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `simulate_imt` - Simular IMT e Imposto do Selo

Calcula o IMT e o Imposto do Selo da compra de um imóvel em Portugal (tabelas do ano em vigor), incluindo IMT Jovem, não residentes, Açores e Madeira, rústicos e compra para revenda. Devolve a regra aplicada e o link para a simulação no site.

- Arguments: `valor`, `vpt`, `finalidade`, `regiao`, `jovem`, `residente`, `credito`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `simulate_mortgage` - Simular crédito habitação

Simula um crédito habitação com a Euribor atual: prestação, TAN e TAEG aproximadas, MTIC, taxa de esforço com o teste de stress do Banco de Portugal, garantia pública jovem, dinheiro necessário na escritura (entrada, IMT, selos) e plano anual. Devolve o link da simulação.

- Arguments: `valor`, `entrada`, `prazo`, `tipo`, `indexante`, `spread`, `tanFixa`, `anosFixos`, `idade`, `jovem`, `rendimento`, `outrasPrestacoes`, `finalidade`, `regiao`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `simulate_capital_gains` - Simular mais-valias na venda de casa

Calcula o IRS das mais-valias na venda de um imóvel por um residente: coeficiente de desvalorização da moeda, despesas e obras, 50% englobado com os escalões de IRS, reinvestimento (habitação própria, arrendamento a renda moderada, PPR 65+). Devolve o valor que fica e o link.

- Arguments: `venda`, `valorAquisicao`, `anoAquisicao`, `mesAquisicao`, `mesVenda`, `aquisicao`, `despesasCompra`, `despesasVenda`, `obras`, `hpp12`, `reinvest`, `reinvestido`, `emprestimo`, `rendimento`, `conjunta`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `estimate_value` - Quanto vale uma casa

Estima o valor de venda e a renda de uma casa (apartamento ou moradia) com os dados oficiais do INE da freguesia ou concelho, ajustados por área, estado e extras; inclui intervalo, confiança e anúncios comparáveis do portal. Serve também para terreno e ruínas (estado 'ruina').

- Arguments: `location`, `tipo`, `area`, `quartos`, `estado`, `garagem`, `exterior`, `piscina`, `elevador`, `terreno`, `terrenoTipo`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `official_prices` - Preço oficial por m² (INE) de uma zona

Dados oficiais do INE para um distrito, concelho ou freguesia: valor mediano das vendas por m² (total, casas novas, usadas), variação anual e evolução trimestral, avaliação bancária, rendas por m² dos novos contratos, e as zonas abaixo. Para citar: 'Portal Imobiliário, com dados do INE'.

- Arguments: `location`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

## Agencies and owners

### `list_feeds` - Feeds de importação

Lista os feeds de importação automática da conta e das agências que gere (o XML ou CSV do programa de gestão), com o estado da última sincronização e o número de anúncios.

- Arguments: none
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `test_feed` - Testar um feed

Lê o endereço de um feed XML ou CSV (Kyero, eGO, Casafari, Zome...) e mostra quantos imóveis tem, uma amostra e os problemas, sem gravar nada.

- Arguments: `url`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: true

### `add_feed` - Ligar um feed

Liga o feed do programa de gestão a uma agência e faz já a primeira importação; depois sincroniza todos os dias (novos entram, alterados atualizam, os que saem do feed são retirados após duas sincronizações). Máximo 5 feeds por agência e 3000 imóveis por feed. Testa primeiro com test_feed.

- Arguments: `url`, `agency_id`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: true

### `run_feed` - Sincronizar um feed agora

Importa agora um feed (feed_id de list_feeds): cria, atualiza e retira anúncios conforme o feed.

- Arguments: `feed_id`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: true

### `toggle_feed` - Pausar ou retomar um feed

Pausa um feed ativo ou retoma um pausado (feed_id). Enquanto pausado não sincroniza; os anúncios ficam.

- Arguments: `feed_id`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `delete_feed` - Apagar um feed

Apaga a ligação a um feed (feed_id). Os anúncios já importados ficam. Confirma com o utilizador antes.

- Arguments: `feed_id`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: false

### `list_properties` - Listar os meus imóveis

Lista os imóveis do utilizador (e das suas agências), com filtros. Para admins, all=true lista todo o portal.

- Arguments: `query`, `status`, `operation`, `type`, `concelho`, `agency_id`, `missing`, `limit`, `offset`, `all`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `get_property` - Ver um imóvel

Detalhe completo de um imóvel (por id, ref PIxxxxx ou external_ref).

- Arguments: `id`, `ref`, `external_ref`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `create_property` - Criar anúncio

Cria um anúncio. Por omissão fica publicado (status active) se tiver localização e preço; usa status='draft' para rascunho.

- Arguments: `property`, `agency_id`, `create_agents`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: true

### `update_property` - Alterar anúncio

Atualiza só os campos indicados de um imóvel (identifica por id, ref ou external_ref). Fotos novas em 'photos' são acrescentadas.

- Arguments: `id`, `ref`, `external_ref`, `changes`, `create_agents`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: true

### `import_properties` - Importar vários imóveis

Importa vários imóveis de uma vez (até 500 por chamada) a partir de dados estruturados, ideal quando leste um CSV, Excel ou PDF do cliente. Cada item com external_ref existente é atualizado; os outros são criados e publicados. Usa dry_run=true primeiro para ver os erros sem gravar.

- Arguments: `properties`, `agency_id`, `publish`, `dry_run`, `agent_id`, `create_agents`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: true

### `import_csv` - Importar CSV

Importa um CSV (texto ou URL público). Deteta colunas em PT/EN automaticamente (ou usa 'mapping': {coluna: campo}). dry_run=true (por omissão) mostra a correspondência e a validação sem gravar; repete com dry_run=false para importar.

- Arguments: `csv_text`, `csv_url`, `mapping`, `agency_id`, `dry_run`, `publish`, `agent_id`, `create_agents`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: true

### `set_status` - Mudar estado (vendido, reservado...)

Muda o estado de um ou mais imóveis: active (publicado), draft, reserved, sold, rented, inactive.

- Arguments: `ids`, `refs`, `status`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: true

### `add_photos` - Acrescentar fotos

Acrescenta fotos a um imóvel a partir de URLs públicos (descarregadas e convertidas em segundo plano).

- Arguments: `id`, `ref`, `external_ref`, `urls`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: true

### `delete_property` - Remover anúncio

Remove um anúncio do portal (as fotos são apagadas; fica um registo mínimo para estatística). Indica o motivo: sold_here (vendido pelo portal), sold_elsewhere, rented, off_market, duplicate, other. Se foi vendido/arrendado e o utilizador disser o valor, passa-o em note. Prefere set_status 'inactive' se o utilizador só quiser escondê-lo.

- Arguments: `id`, `ref`, `external_ref`, `reason`, `note`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: false

### `report_overview` - Relatório dos anúncios

Relatório dos anúncios do utilizador/agência: totais por estado, tipo e concelho, preços (média, mediana, €/m²), visualizações e contactos no período, anúncios mais vistos e anúncios incompletos.

- Arguments: `period_days`, `agency_id`, `all`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `report_leads` - Relatório de contactos

Lista os contactos (leads) recebidos no período, com o imóvel, para seguimento.

- Arguments: `period_days`, `property_id`, `limit`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `export_properties` - Exportar imóveis (CSV)

Exporta os imóveis do utilizador/agência para CSV (texto), para backup ou para levar para outra ferramenta.

- Arguments: `agency_id`, `status`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `list_agents` - Agentes da agência

Lista os agentes de uma agência (agency_id), com o número de anúncios ativos de cada um.

- Arguments: `agency_id`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `add_agent` - Acrescentar agente

Acrescenta um agente a uma agência (agency_id): nome, email, telefone e cargo.

- Arguments: `agency_id`, `name`, `email`, `phone`, `title`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `list_developments` - Os meus empreendimentos

Lista os empreendimentos (obra nova) da conta e das agências que gere: fase, frações, disponíveis, preço mínimo e link.

- Arguments: none
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `get_development` - Detalhe de um empreendimento

Detalhe de um empreendimento (id) com as frações ligadas.

- Arguments: `id`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `create_development` - Criar empreendimento

Cria um empreendimento (obra nova) de uma agência; as frações são anúncios normais que depois se ligam com link_development_units. Localização por nomes (distrito, concelho, freguesia).

- Arguments: `agency_id`, `data`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `update_development` - Alterar empreendimento

Altera os campos de um empreendimento (id, data com os campos a mudar).

- Arguments: `id`, `data`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: false

### `link_development_units` - Ligar frações

Liga anúncios (property_ids) a um empreendimento (id) como frações.

- Arguments: `id`, `property_ids`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `unlink_development_units` - Desligar frações

Desliga anúncios (property_ids) de um empreendimento (id); os anúncios ficam.

- Arguments: `id`, `property_ids`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `delete_development` - Apagar empreendimento

Apaga um empreendimento (id); as frações ficam como anúncios. Confirma com o utilizador antes.

- Arguments: `id`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: false

### `audit_listings` - Auditar qualidade dos anúncios

Lista os anúncios ativos (ou rascunhos) com problemas que reduzem visitas e contactos: sem fotos ou com poucas, descrição curta, sem classe energética (obrigatória para publicar), sem mapa, sem área, preço muito acima da mediana da zona, sem atualização há mais de 90 dias. Devolve por anúncio a lista de problemas e o que fazer.

- Arguments: `agency_id`, `status`, `limit`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `list_photos` - Fotos de um anúncio

Lista as fotos de um anúncio (id, ref ou external_ref) pela ordem, com a capa primeiro.

- Arguments: `id`, `ref`, `external_ref`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `delete_photos` - Apagar fotos

Apaga fotos de um anúncio (photo_ids de list_photos). Não se pode desfazer: confirma com o utilizador antes.

- Arguments: `id`, `ref`, `external_ref`, `photo_ids`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: false

### `reorder_photos` - Ordenar fotos

Define a ordem das fotos de um anúncio (photo_ids pela ordem; a primeira é a capa).

- Arguments: `id`, `ref`, `external_ref`, `photo_ids`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `set_cover_photo` - Escolher a capa

Põe uma foto (photo_id) como capa do anúncio.

- Arguments: `id`, `ref`, `external_ref`, `photo_id`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `list_leads` - Contactos recebidos

Lista os contactos recebidos (pedidos de informação dos anúncios e da página da agência), por ler primeiro.

- Arguments: `unread_only`, `period_days`, `limit`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `mark_leads_read` - Marcar contactos como lidos

Marca contactos (lead_ids de list_leads) como lidos.

- Arguments: `lead_ids`
- Hints: readOnlyHint: false, destructiveHint: false, openWorldHint: false

### `archive_leads` - Arquivar contactos

Arquiva contactos (lead_ids): saem da caixa de entrada. Confirma com o utilizador antes.

- Arguments: `lead_ids`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: false

### `get_agency` - Página da agência

Mostra a página da agência: dados, números dos últimos 30 dias (telefone visto, cliques no email e no site), avaliações e o selo para o site.

- Arguments: `agency_id`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `update_agency` - Alterar a página da agência

Altera dados públicos da página da agência: nome, designação da empresa, AMI, descrição (só texto, sem contactos nem links), morada, telefone, WhatsApp, email ou site. Substitui os valores atuais: confirma com o utilizador antes.

- Arguments: `agency_id`, `changes`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: false

### `list_agency_reviews` - Avaliações da agência

Lista as avaliações publicadas da agência (só de clientes que a contactaram pelo portal, verificadas antes de publicar).

- Arguments: `agency_id`
- Hints: readOnlyHint: true, destructiveHint: false, openWorldHint: false

### `reply_to_review` - Responder a uma avaliação

Publica a resposta da agência a uma avaliação (review_id, text), visível a todos na página da agência; substitui uma resposta anterior. Cordial e sem dados pessoais do cliente. Mostra o texto ao utilizador antes de publicar.

- Arguments: `agency_id`, `review_id`, `text`
- Hints: readOnlyHint: false, destructiveHint: true, openWorldHint: true
