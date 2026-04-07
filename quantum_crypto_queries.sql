-- ============================================================================
-- PROJETO: QUANTUM CRYPTO ANALYTICS (QCA)
-- OBJETIVO: Análise de Séries Temporais e Volatilidade via SQL (OLAP)
-- DESCRITIVO: Este script realiza o processamento de indicadores financeiros 
--             utilizando o motor DuckDB, servindo de base para modelos de 
--             otimização quântica (QAOA).
-- AUTOR: Gabriel Sales Ribeiro
-- DATA: 2026
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. LIMPEZA E INSPEÇÃO INICIAL
-- Verificação de integridade dos dados importados do yfinance.
-- ----------------------------------------------------------------------------
SELECT 
    COUNT(*) AS total_registros,
    MIN(data) AS data_inicio,
    MAX(data) AS data_fim
FROM historico_btc;

-- ----------------------------------------------------------------------------
-- 2. MÉDIAS MÓVEIS CRUZADAS (7 vs 21 dias)
-- Aplicação de Window Functions para suavização de ruído estatístico.
-- Em Física, este processo é análogo a um filtro de média móvel (Low-pass filter).
-- ----------------------------------------------------------------------------
SELECT 
    data,
    fechamento,
    AVG(fechamento) OVER (ORDER BY data ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS media_7d,
    AVG(fechamento) OVER (ORDER BY data ROWS BETWEEN 20 PRECEDING AND CURRENT ROW) AS media_21d,
    -- Identificação de tendência (Sinal de Momentum)
    CASE 
        WHEN AVG(fechamento) OVER (ORDER BY data ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) > 
             AVG(fechamento) OVER (ORDER BY data ROWS BETWEEN 20 PRECEDING AND CURRENT ROW) 
        THEN 'Tendência Alta' ELSE 'Tendência Baixa' 
    END AS status_mercado
FROM historico_btc
ORDER BY data DESC;

-- ----------------------------------------------------------------------------
-- 3. ANÁLISE DE VOLATILIDADE E ENERGIA DO SISTEMA
-- Identificação de regimes de alta flutuação (volatilidade > 5%).
-- ----------------------------------------------------------------------------
SELECT 
    data,
    abertura,
    fechamento,
    ((maxima - minima) / abertura) * 100 AS volatilidade_pct,
    (maxima - minima) AS amplitude_absoluta
FROM historico_btc
WHERE ((maxima - minima) / abertura) * 100 > 5
ORDER BY volatilidade_pct DESC;

-- ----------------------------------------------------------------------------
-- 4. CÁLCULO DE RETORNO DIÁRIO E MOMENTUM (LAG FUNCTION)
-- Demonstração de acesso a estados anteriores do sistema (Memória do Mercado).
-- ----------------------------------------------------------------------------
WITH cte_retorno AS (
    SELECT 
        data,
        fechamento,
        LAG(fechamento) OVER (ORDER BY data) AS fechamento_anterior
    FROM historico_btc
)
SELECT 
    data,
    fechamento,
    fechamento_anterior,
    ((fechamento / fechamento_anterior) - 1) * 100 AS retorno_diario_pct
FROM cte_retorno
WHERE fechamento_anterior IS NOT NULL
ORDER BY data DESC;

-- ----------------------------------------------------------------------------
-- 5. AGRUPAMENTO MENSAL E MÁXIMAS (QUERY OLAP)
-- Resumo executivo para análise de ciclos de mercado.
-- ----------------------------------------------------------------------------
SELECT 
    STRFTIME('%Y-%m', data) AS mes_referencia,
    ROUND(AVG(fechamento), 2) AS preco_medio_mensal,
    ROUND(MAX(maxima), 2) AS topo_do_mes,
    CAST(SUM(volume) AS BIGINT) AS volume_total_negociado
FROM historico_btc
GROUP BY mes_referencia
ORDER BY mes_referencia DESC;


