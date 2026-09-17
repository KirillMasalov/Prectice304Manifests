{{/*
Имя чарта
*/}}
{{- define "echo-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Полное имя (release-name + chart-name)
*/}}
{{- define "echo-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Общие лейблы
*/}}
{{- define "echo-chart.labels" -}}
helm.sh/chart: {{ include "echo-chart.name" . }}-{{ .Chart.Version }}
{{ include "echo-chart.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Селекторные лейблы
*/}}
{{- define "echo-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "echo-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: echo
{{- end }}