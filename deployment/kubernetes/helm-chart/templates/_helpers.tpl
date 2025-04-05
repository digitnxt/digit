{{/*
Expand the name of the chart.
*/}}
{{- define "digitnxt.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "digitnxt.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "digitnxt.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "digitnxt.labels" -}}
helm.sh/chart: {{ include "digitnxt.chart" . }}
{{ include "digitnxt.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "digitnxt.selectorLabels" -}}
app.kubernetes.io/name: {{ include "digitnxt.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "digitnxt.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "digitnxt.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "digitnxt.secretName" -}}
{{- if .Values.secrets.create }}
{{- default (include "digitnxt.fullname" .) .Values.secrets.name }}
{{- else }}
{{- default "default" .Values.secrets.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the config map to use
*/}}
{{- define "digitnxt.configMapName" -}}
{{- if .Values.configMap.create }}
{{- default (include "digitnxt.fullname" .) .Values.configMap.name }}
{{- else }}
{{- default "default" .Values.configMap.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the persistent volume claim to use
*/}}
{{- define "digitnxt.pvcName" -}}
{{- if .Values.persistence.create }}
{{- default (include "digitnxt.fullname" .) .Values.persistence.name }}
{{- else }}
{{- default "default" .Values.persistence.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the network policy to use
*/}}
{{- define "digitnxt.networkPolicyName" -}}
{{- if .Values.networkPolicies.create }}
{{- default (include "digitnxt.fullname" .) .Values.networkPolicies.name }}
{{- else }}
{{- default "default" .Values.networkPolicies.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the pod security policy to use
*/}}
{{- define "digitnxt.pspName" -}}
{{- if .Values.security.podSecurityPolicies.create }}
{{- default (include "digitnxt.fullname" .) .Values.security.podSecurityPolicies.name }}
{{- else }}
{{- default "default" .Values.security.podSecurityPolicies.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the role to use
*/}}
{{- define "digitnxt.roleName" -}}
{{- if .Values.security.rbac.create }}
{{- default (include "digitnxt.fullname" .) .Values.security.rbac.name }}
{{- else }}
{{- default "default" .Values.security.rbac.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the role binding to use
*/}}
{{- define "digitnxt.roleBindingName" -}}
{{- if .Values.security.rbac.create }}
{{- default (include "digitnxt.fullname" .) .Values.security.rbac.bindingName }}
{{- else }}
{{- default "default" .Values.security.rbac.bindingName }}
{{- end }}
{{- end }} 